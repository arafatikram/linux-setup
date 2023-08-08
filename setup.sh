#!/bin/bash

RED='\033[0;31m';
NC='\033[0m'; # No Color
GREEN='\033[0;32m';
YELLOW='\033[1;33m';

CWD=`pwd`;

delay_after_message=3;

if [[ $EUID -ne 0 ]]; then
	echo "This script must be run with sudo (sudo -i)" 
   exit 1
fi

read -p "Please enter your username: " target_user;

if id -u "$target_user" >/dev/null 2>&1; then
    echo "User $target_user exists! Proceeding.. ";
else
    echo 'The username you entered does not seem to exist.';
    exit 1;
fi


# function to run command as non-root user
run_as_user() {
	sudo -u $target_user bash -c "$1";
}




sudo apt update
sudo apt upgrade -y


# Some basic shell utlities
printf "${YELLOW}Installing git, curl, preload, Python. ${NC}\n";
sleep $delay_after_message;
apt install git -y
apt install curl -y
apt install nfs-common -y
apt install preload -y
apt install python3 -y
apt install python3-pip -y


# nautilus file manager and extention
printf "${YELLOW}Installing nautilus file manager and extention${NC}\n";
apt install nautilus -y
apt install nautilus-extension-gnome-terminal -y
apt install nautilus-admin -y
apt install plank -y

printf "${GREEN}Downloading WhiteSur-GTK-Theme${NC}\n";
git clone https://github.com/vinceliuice/WhiteSur-gtk-theme.git
printf "${YELLOW}Installing WhiteSur-GTK-Theme${NC}\n";
cd WhiteSur-gtk-theme
./install.sh --nord
cd ..

printf "${GREEN}Downloading Nord-Icon${NC}\n";
git clone https://github.com/alvatip/Nordzy-icon.git
printf "${YELLOW}Installing Nord-Icon${NC}\n";
cd Nordzy-icon
./install.sh 
cd ..
printf "${GREEN}Downloading GNome Terminal Theme${NC}\n";
git clone https://github.com/nordtheme/gnome-terminal.git
printf "${YELLOW}Installing GNome Terminal Theme${NC}\n";
cd gnome-terminal/src
./nord.sh
cd ..
cd ..
sudo chown -R target_user:target_user gnome-terminal Nordzy-icon WhiteSur-gtk-theme


printf "${YELLOW}Installing Additonal Fonts${NC}\n";
cp -rfv fonts /home/$target_user/.local/share/
printf "${YELLOW}Copying New Wallpaper${NC}\n";
cp -rfv wallpapers /home/$target_user/.local/share/
printf "${YELLOW}Copying Plank Theme${NC}\n";
cp -rfv plank-dock-theme/nordzy-black /home/$target_user/.local/share/plank/themes  




#Install Z Shell
printf "${YELLOW}Installing ZSH (Shell)${NC}\n";
sleep $delay_after_message;
apt install zsh -y
sleep 2;
chsh -s /bin/zsh

git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/powerlevel10k
echo 'source ~/powerlevel10k/powerlevel10k.zsh-theme' >>~/.zshrc


# Remove thunderbird
printf "${RED}Removing thunderbird completely${NC}\n";
sleep $delay_after_message;
apt-get purge thunderbird* -y



# Gnome tweak tool
printf "${YELLOW}Installing gnome-tweak-tool${NC}\n";
sleep $delay_after_message;
apt install gnome-tweaks -y;

#Install Open-SSH Server
printf "${YELLOW}Installing OpenSSH Server ${NC}\n";
sleep $delay_after_message;
apt install openssh-server -y
systemctl enable ssh
systemctl start ssh


printf "${YELLOW}Install prerequisits for Gnome Shell Extentions${NC}\n";
sleep $delay_after_message;
apt install gnome-shell-extensions -y



#  adding cloudflare WARP+ repo
curl https://pkg.cloudflareclient.com/pubkey.gpg | sudo apt-key add -
echo 'deb http://pkg.cloudflareclient.com/ bionic main' | sudo tee /etc/apt/sources.list.d/cloudflare-client.list
echo 'deb http://pkg.cloudflareclient.com/ xenial main' | sudo tee /etc/apt/sources.list.d/cloudflare-client.list
echo 'deb http://pkg.cloudflareclient.com/ xenial main' | sudo tee /etc/apt/sources.list.d/cloudflare-client.list
echo 'deb http://pkg.cloudflareclient.com/ bullseye main' | sudo tee /etc/apt/sources.list.d/cloudflare-client.list
echo 'deb http://pkg.cloudflareclient.com/ buster main' | sudo tee /etc/apt/sources.list.d/cloudflare-client.list
echo 'deb http://pkg.cloudflareclient.com/ stretch main' | sudo tee /etc/apt/sources.list.d/cloudflare-client.list

# Installing cloudflare WARP+ 
apt install cloudflare-warp

# connecting WARP+
warp-cli register
warp-cli connect
warp-cli status


 
apt dist-upgrade -y;
chsh -s /bin/zsh
