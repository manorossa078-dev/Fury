#!/bin/bash

readonly REQUIRED=("metasploit-framework")
readonly RED="\e[1;31m"
readonly GREEN="\e[1;32m"
readonly YELLOW="\e[1;33m"
readonly RESET="\e[0m"

for tool in "${REQUIRED[@]}"; do
        dpkg -s "$tool" &> /dev/null
        if [ $? -eq 0 ]; then
                echo -e "${GREEN}[+] $tool is already installed."
        else
                echo -e "${YELLOW}[*] $tool isn't installed. Installing now...${RESET}"
                yes | sudo apt install $tool
                if [ $? -eq 0 ]; then
                        echo -e "${GREEN}[+] Tool $tool succesfully installed!"
                        clear
                else
                        echo -e "${RED}[!] Error on the installation of $tool."
                fi
        fi
done
echo -e "${GREEN}[+] All tools are installed!"
