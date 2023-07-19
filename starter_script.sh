#!/usr/bin/env bash

echo "starting script"

echo "installing packages"
# Install packages 
sudo apt update && sudo apt install  \
        xclip \
        git

echo "Initiating docker"
sudo groupadd docker
sudo usermod -aG docker $USER

echo "Setting up SSH"
# Add SSH
if [[ ! -f ~/.ssh/id_rsa ]]; then
    ssh-keygen -q -t rsa -N '' -f ~/.ssh/id_rsa <<<y >/dev/null 2>&1
    ssh-add ~/.ssh/id_rsa
    cat ~/.ssh/id_rsa.pub | xclip -sel clip
    echo "SSH key created and copied to clipboard"
    echo "Paste it in the 'key' field in the form that opens in your browser"
    echo "Opening browser..."
    xdg-open https://github.com/settings/ssh/new 2>/dev/null
    echo ""
    read -p "After you've saved the key, press enter to continue..."
    echo "Great!"
else
    echo "You have an ssh key already. (Make sure it has been added to github)"
fi

# Restart computer
echo "Rebooting"
echo "You're computer needs to reboot itself in order to finish the set up process."
echo "Please make sure that you save anything that you need to."
read -p "Press enter to continue..."
sudo reboot


