#!/bin/bash
#Post-install Script for my void distribution

#printf "\n\nUpdating packages to latest version\n\n"
#sudo xbps-install -Suvy

#Variables go here:

#Check if tput exists:
if ! command -v tput &> /dev/null; then
	#tput could not be found
	BOLD=""
	RESET=""
	FG_SKYBLUE=""
	FG_ORANGE=""
	BG_AQUA=""
	FG_BLACK=""
	FG_ORANGE=""
	UL=""
	RUL=""
else
	BOLD=$(tput bold)
	RESET=$(tput sgr0)
	FG_SKYBLUE=$(tput setaf 122)
	FG_ORANGE=$(tput setaf 208)
	BG_AQUA=$(tput setab 45)
	FG_BLACK=$(tput setaf 16)
	FG_ORANGE=$(tput setaf 214)
	UL=$(tput smul)
	RUL=$(tput rmul)
fi

#Download some required packages:
doPackageInstall()
{
	printf "\nDownloading some required packages\n\n"
	printf "\nInstalling the Xorg server, input drivers and a few additional utilities\n\n"                 		
	sudo xbps-install -Svy xorg-minimal
	printf "\nInstalling Basic font files and font encoding utilites\n\n"
	sudo xbps-install -Svy xorg-fonts	
	printf "\nInstalling xterm emulator\n\n"
	sudo xbps-install -Svy xterm					
	printf "\nInstalling clock for twm\n\n"
	sudo xbps-install -Svy clock				
	printf "\nInstalling basic window wanager\n\n"
	sudo xbps-install -Svy twm					
	printf "\nInstalling Terminal multiplexer\n\n"
	sudo xbps-install -Svy tmux					
	printf "\nInstalling AMD video driver\n\n" 
	sudo xbps-install -Svy xf86-video-amdgpu
	printf "\nInstalling Source code control versioning system\n\n"
	sudo xbps-install -Svy git				
	printf "\nInstalling THE text editor :-)\n\n"
	sudo xbps-install -Svy vim				
	printf "\nInstalling location db and lookup utilities\n\n"
	sudo xbps-install -Svy mlocate			
	printf "\nInstalling a simple image viewer\n\n"
	udo xbps-install -Svy feh				
	printf "\nInstalling a utility for displaying window and font properties in an X server\n\n"
	sudo xbps-install -Svy xprop				
	printf "\nInstalling a utility that sets the size orientation and/or the reflection of the outputs for a screen.\n\n"
	sudo xbps-install -Svy xrandr			
	printf "\nInstalling a visual front end for arandr\n\n"
	sudo xbps-install -Svy arandr			
	printf "\nInstalling rxvt-unicode terminal editor\n\n"
	sudo xbps-install -Svy rxvt-unicode			
	printf "\nInstalling GNU compiler and associated development utilities\n\n"
	sudo xbps-install -Svy base-devel			
	printf "\nInstalling IRC chat client\n\n"
	sudo xbps-install -Svy irssi					
	printf "\nInstalling Graphic image manipulation program\n\n"
	sudo xbps-install -Svy gimp				
	printf "\nInstalling text based music player\n\n"
	sudo xbps-install -Svy cmus					
	printf "\nInstalling GUI based bittorrent client\n\n"
	sudo xbps-install -Svy qbittorrent				
	printf "\nInstalling Advanced Linux Sound Architercture files and utilities\n\n"
	sudo xbps-install -Svy alsa-utils				
	printf "\nInstalling Curl command line downloading tool\n\n"
	sudo xbps-install -Svy curl				
	printf "\nInstalling Wget. It's similar to Curl\n\n" 
	sudo xbps-install -Svy wget					
	printf "\nInstalling dropbox.\n\n"
	sudo xbps-install -Svy dropbox
	printf "\nInstalling Python.\n\n"
	sudo xbps-install -Svy python
	printf "\nInstalling Cronie\n\n"
	sudo xbps-install -Svy cronie
	printf "\nInstalling OpenBox Desktop Environment\n\n"
	sudo xbps-install -Svy openbox
	printf "Installing the X config merge tool\n\n"
	sudo xbps-install -Svy xrdb
	printf "installing a utility for modifying keymaps and pointer button mappings in X\n\n"
	sudo xbps-install -Svy xmodmap
	printf "Installing the Firefox Web Browser\n\n"
	sudo xbps-install -Svy firefox
	printf "Installing a system diagnostics tool\n\n"
	sudo xbps-install -Svy inxi
	printf "Installing a tool that restores iptables rules on boot\n\n"
	sudo xbps-install -Svy runit-iptables
	printf "Installing an Internet utility suite\n\n"
	sudo xbps-install -Svy inetutils
	printf "Installing  the Socklog logger\n\n"
	sudo xbps-install -Svy socklog
	printf "Installing Void Linux config for Socklog \n\n"
	sudo xbps-install -Svy socklog-void
        printf "installing a suite for debugging and profiling programs"
        sudo xbps-install -Svy valgrind
        printf "installing Radare2, a hex editor, dissambler and debugger"
        sudo xbps-install -Svy radare2
        printf "Installing ired, Interactice raw editor"
        sudo xbps-install -Svy ired
        printf "Installing Cutter, a GUI for Radare2"
        sudo xbps-install -Svy cutter
        printf "Installing a collection of tools for use with XBPS"
        sudo xbps-install -Svy xtools
}

createDirectories()
{
    if [[ -d ${HOME}/tmp ]] ; then
        echo -e "The directory $BOLD$HOME/tmp$RESET already exists. Skipping..."
    else
	mkdir $HOME/tmp
    fi

    if [[ -d ${HOME}/sCrAtCh ]] ; then
	echo -e "The directory $BOLD$HOME/sCrAtCh$RESET already exists. Skipping..."
    else
	mkdir $HOME/sCrAtCh
    fi

    if [[ -d ${HOME}/BACKUP ]] ; then
	echo -e "The directory $BOLD$HOME/BACKUP$RESET already exists. Skipping..."
    else
	mkdir $HOME/BACKUP
    fi

    if [[ -d ${HOME}/void-packages ]] ; then
	echo -e "The directory $BOLD$HOME/void-packages$RESET already exists. Skipping..."
    else
	echo -e "Setting the source packages Tree...."
	cd $HOME 
	git clone git://github.com/eamoc/void-packages.git
	cd void-packages
	./xbps-src binary-bootstrap
    fi
}

addSymbolicLinks()
{

    if [[ -f $HOME/.bashrc ]] ; then
        rm $HOME/.bashrc
        echo "Deleted existing .bashrc\n\n"
        ln -s $HOME/.config/BASHRC $HOME/.bashrc
        echo "Created new symbolic link -> .bashrc"
  
    else
        ln -s $HOME/.config/BASHRC $HOME/.bashrc
        echo "Created new symbolic link -> .bashrc"
    fi
    
    if [[ -f $HOME}/.xinitrc ]] ; then
        rm $HOME/.xinitrc
        echo "Deleted existing .xinitrc\n\n"
        ln -s $HOME/.config/XINITRC $HOME/.xinitrc
        echo "Created new symbolic link -> .xinitrc"
  
    else
        ln -s $HOME/.config/XINITRC $HOME/.xinitrc
        echo "Created new symbolic link -> .xinitrc"
    fi

    if [[ -f $HOME}/.Xresources ]] ; then
        rm $HOME/.Xresources
        echo "Deleted existing .Xresources\n\n"
        ln -s $HOME/.config/XRESOURCES $HOME/.Xresources
        echo "Created new symbolic link -> .Xresources."

    else
        ln -s $HOME/.config/XRESOURCES $HOME/.Xresources
        echo "Created new symbolic link -> .Xresources"
    fi

    if [[ -f $HOME}/.asoundrc ]] ; then
        rm $HOME/.asoundrc
        echo "Deleted existing .asoundrc\n\n"
        ln -s $HOME/.config/AUDIO_CONFIG $HOME/.asoundrc
        echo "Created new symbolic link -> .asoundrc"
    
    else
        ln -s $HOME/.config/AUDIO_CONFIG $HOME/.asoundrc
        echo "Created new symbolic link -> .asoundrc"
    fi

    if [[ -f $HOME}/.vimrc ]] ; then
        rm $HOME/.vimrc
        echo "Deleted existing .vimrc\n\n"
        ln -s $HOME/.config/VIM_RC $HOME/.vimrc
        echo "Created new symbolic link -> .vimrc"
    
    else
        ln -s $HOME/.config/VIM_RC $HOME/.vimrc
        echo "Created new symbolic link -> .vimrc"
    fi
   
    if [[ -d /usr/share/X11/xorg.conf.d/ ]] ; then
        sudo ln -s $HOME/.config/IRISH_XORG_LOCALE /usr/share/X11/xorg.conf.d/20-keyboard.conf
    fi

# Adding symbolic links for iptables and ip6tables I.e enabling the services

    if [[ -h /var/service/iptables ]] ; then
        sudo rm /var/service/iptables
        echo "Deleted existing symlink for iptables\n\n"
        sudo ln -s /etc/sv/iptables /var/service 
        echo "Created new symbolic link -> /var/service/iptables"
    else
        sudo ln -s /etc/sv/iptables /var/service
        echo "Created new symbolic link -> /var/service/iptables"
    fi


    if [[ -h /var/service/ip6tables ]] ; then
        sudo rm /var/service/ip6tables
        echo "Deleted existing symlink for ipt6ables\n\n"
        sudo ln -s /etc/sv/ip6tables /var/service 
        echo "Created new symbolic link -> /var/service/ip6tables"
    else
        sudo ln -s /etc/sv/ip6tables /var/service
        echo "Created new symbolic link -> /var/service/ip6tables"
    fi

# Symbolic links for socklog

    if [[ -h /var/service/socklog-unix ]] ; then
        sudo rm /var/service/socklog-unix
        echo "Deleted existing symlink for socklog-unix\n\n"
        sudo ln -s /etc/sv/socklog-unix /var/service 
        echo "Created new symbolic link -> /var/service/socklog-unix"
    else
        sudo ln -s /etc/sv/socklog-unix /var/service
        echo "Created new symbolic link -> /var/service/socklog-unix"
    fi


    if [[ -h /var/service/nanoklogd ]] ; then
        sudo rm /var/service/nanoklogd
        echo "Deleted existing symlink for nanoklogd\n\n"
        sudo ln -s /etc/sv/nanoklogd /var/service 
        echo "Created new symbolic link -> /var/service/nanoklogd"
    else
        sudo ln -s /etc/sv/nanoklogd /var/service
        echo "Created new symbolic link -> /var/service/nanoklogd"
    fi

}

usersAndGroups()
{ 
    #Adding the user to the socklog group
    sudo usermod -aG $USER socklog
}

sourceBashrc()
{ 
    echo "Updating .bashrc\n\n"
    . ~/.bashrc
}

#Call the functions above...
doPackageInstall
createDirectories
addSymbolicLinks
usersAndGroups
sourceBashrc
