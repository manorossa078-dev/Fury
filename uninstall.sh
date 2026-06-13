#!/bin/bash

readonly REQUIRES=("sherlock" "john" "maltego")
readonly PYTHON_REQ=("maigret")
readonly GREEN="\e[1;32m"
readonly YELLOW="\e[1;33m"
readonly RESET="\e[0m"

echo -e "${GREEN}"
cat << "EOF"
    ____       ____           ____           __        ____
   / __ \___  / / /_____ _   /  _/___  _____/ /_____ _/ / /
  / / / / _ \/ / __/ __ `/   / // __ \/ ___/ __/ __ `/ / / 
 / /_/ /  __/ / /_/ /_/ /  _/ // / / (__  ) /_/ /_/ / / /  
/_____/\___/_/\__/\__,_/  /___/_/ /_/____/\__/\__,_/_/_/
EOF

for tool in "${REQUIRES[@]}"; do
	if [ ! $? -eq 0 ]; then
		echo -e "${GREEN}[+] Bash requirements already removed."
	else
		echo -e "${YELLOW}"
		yes | sudo apt purge $tool
		echo -e "${GREEN}[+] Bash requirements uninstalled!"
	fi
done
for pythonTool in "${PYTHON_REQ[@]}"; do
	if [ ! pip show $pythonTool 2> /dev/null ]; then
		echo -e "${GREEN}[+] All pyhton tools are uninstalled!"
		exit 0
	else
		echo -e "${YELLOW}[*] Uninstalling $pythonTool..."
		yes | pip3 uninstall $pythonTool
		echo -e "${GREEN}[+] $pythonTool uninstalled succesfully!"
echo -e "${GREEN}[+] All tools are installed."
