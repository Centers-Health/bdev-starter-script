#!/usr/bin/env bash

_print(){
tput setaf 6
    echo "================================"
    echo ">>> $1"
    echo "================================"
    echo
tput sgr0

}

clear

tput setaf 6
cat <<'HERE'
 ____  _   _ ____    ____            _
|  _ \| | | / ___|  / ___| _   _ ___| |_ ___ _ __ ___
| | | | |_| \___ \  \___ \| | | / __| __/ _ \ '_ ` _ \
| |_| |  _  |___) |  ___) | |_| \__ \ ||  __/ | | | | |
|____/|_| |_|____/  |____/ \__, |___/\__\___|_| |_| |_|
                           |___/
 ___           _        _ _
|_ _|_ __  ___| |_ __ _| | | ___ _ __
 | || '_ \/ __| __/ _` | | |/ _ \ '__|
 | || | | \__ \ || (_| | | |  __/ |
|___|_| |_|___/\__\__,_|_|_|\___|_|

 ____                ____            _       _
|  _ \ _ __ ___     / ___|  ___ _ __(_)_ __ | |_
| |_) | '__/ _ \____\___ \ / __| '__| | '_ \| __|
|  __/| | |  __/_____|__) | (__| |  | | |_) | |_
|_|   |_|  \___|    |____/ \___|_|  |_| .__/ \__|
                                      |_|

HERE

tput sgr0

_print "Installing Packages"

# Install packages
sudo apt update && sudo apt install -y  \
        xclip \
        git

_print "Initiating Docker"
sudo groupadd docker
sudo usermod -aG docker "$USER"

_print "Setting Up SSH"

# Add SSH
if [[ ! -f ~/.ssh/id_rsa ]]; then
    ssh-keygen -q -t rsa -N '' -f ~/.ssh/id_rsa <<<y >/dev/null 2>&1
    ssh-add ~/.ssh/id_rsa
    cat ~/.ssh/id_rsa.pub | xclip -sel clip
    echo "SSH key created and copied to clipboard"
    echo "Paste it in the 'key' field in the form that opens in your browser"
    echo "Opening firefox browser..."
    firefox https://github.com/settings/ssh/new 2>/dev/null
    echo ""
    read -p "After you've saved the key, press enter to continue..."
    echo "Great!"
else
    echo "You have an ssh key already. (Make sure it has been added to github)"
fi

# Restart computer
_print "Rebooting"
echo "You're computer needs to reboot itself in order to finish the set up process."
echo "Please make sure that you save anything that you need to."
read -p "Press enter to continue..."
sudo reboot
