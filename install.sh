#!/bin/bash

readonly REQUIRED=("metaploit-framework")
readonly RED="\e[1;31m"
readonly GREEN="\e[1;32m"
readonly YELLOW="\e[1;33m"
readonly RESET="\e[0m"

for tool in "${REQUIRED[@]}"; do
	if [ $? -eq 0 ]; then
		echo -e "${GREEN}[+] $tool already installed."
	else
		echo -e "${YELLOW}[*] $tool isn't installed. Installing now...${RESET}"
		sudo apt install $tool
	fi
done
echo -e "${GREEN}[+] All tools are installed!"
