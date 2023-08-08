# linux-setup
My personalized Linux desktop setup script for Linux Debian-based distros (mint, Ubuntu) 


The script automatically installs: 
* sshuttle
* *Completely removes thunderbird*
* git, curl, pthon3, pyhton-pip.
* zsh (with `oh-my-zsh` and `powerlevel10k` theme)
* lua 5.1 and z.lua (super fast directory navigation tool)
* nautilus file manager and its extension
* openssh-server
* gnome-tweak-tool
* prerequisites of Gnome shell extensions
* WhiteSur GTK+Icon theme (Nordic theme).
* Fonts and Wallapaper, and Plank docker with nordic theme
* And finally upgrades all the packages in the system to the latest versions.

To run the script, simply type `sudo -i` enter your password. Navigate to the directory where you cloned the repository and then run `./script.sh`.
After the script runs you should run `chsh` in terminal and after entering your password, type: `/bin/zsh` to change shell from Bash to ZSH. Then restart the computer for the change to take effect. Once you restart and open terminal, you will be prompted to configure the `powerlevel0k` theme. Just follow the prompts and set it according to your liking.


