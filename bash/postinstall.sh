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
	printf "\n\nInstalling the Xorg server, input drivers and a few additional utilities\n"
	sudo xbps-install -Svy xorg-minimal
	printf "\n\nInstalling Basic font files and font encoding utilites\n"
	sudo xbps-install -Svy xorg-fonts	
	printf "\n\nInstalling xterm emulator\n"
	sudo xbps-install -Svy xterm					
	printf "\n\nInstalling clock for twm\n"
	sudo xbps-install -Svy clock				
	printf "\n\nInstalling basic window wanager\n"
	sudo xbps-install -Svy twm					
	printf "\n\nInstalling Terminal multiplexer\n"
	sudo xbps-install -Svy tmux					
	printf "\n\nInstalling AMD video driver\n" 
	sudo xbps-install -Svy xf86-video-amdgpu
	printf "\n\nInstalling Source code control versioning system\n"
	sudo xbps-install -Svy git				
	printf "\n\nInstalling THE text editor :-)\n"
	sudo xbps-install -Svy vim				
	printf "\n\nInstalling location db and lookup utilities\n"
	sudo xbps-install -Svy mlocate			
	printf "\n\nInstalling a simple image viewer\n"
	udo xbps-install -Svy feh				
	printf "\n\nInstalling a utility for displaying window and font properties in an X server\n"
	sudo xbps-install -Svy xprop				
	printf "\n\nInstalling a utility that sets the size orientation and/or the reflection of the outputs for a screen.\n"
	sudo xbps-install -Svy xrandr			
	printf "\n\nInstalling a visual front end for arandr\n"
	sudo xbps-install -Svy arandr			
	printf "\n\nInstalling rxvt-unicode terminal editor\n"
	sudo xbps-install -Svy rxvt-unicode			
	printf "\n\nInstalling GNU compiler and associated development utilities\n"
	sudo xbps-install -Svy base-devel			
	printf "\n\nInstalling IRC chat client\n"
	sudo xbps-install -Svy irssi					
	printf "\n\nInstalling Graphic image manipulation program\n"
	sudo xbps-install -Svy gimp				
	printf "\n\nInstalling text based music player\n"
	sudo xbps-install -Svy cmus					
	printf "\n\nInstalling GUI based bittorrent client\n"
	sudo xbps-install -Svy qbittorrent				
	printf "\n\nInstalling Advanced Linux Sound Architercture files and utilities\n"
	sudo xbps-install -Svy alsa-utils				
	printf "\n\nInstalling Curl command line downloading tool\n"
	sudo xbps-install -Svy curl				
	printf "\n\nInstalling Wget. It's similar to Curl\n" 
	sudo xbps-install -Svy wget					
	printf "\n\nInstalling dropbox.\n"
	sudo xbps-install -Svy dropbox
	printf "\n\nInstalling Python.\n"
	sudo xbps-install -Svy python
	printf "\n\nInstalling Cronie\n"
	sudo xbps-install -Svy cronie
	printf "\n\nInstalling OpenBox Desktop Environment\n"
	sudo xbps-install -Svy openbox
	printf "\n\nInstalling the X config merge tool\n"
	sudo xbps-install -Svy xrdb
	printf "\n\nInstalling a utility for modifying keymaps and pointer button mappings in X\n"
	sudo xbps-install -Svy xmodmap
	printf "\n\nInstalling the Firefox Web Browser\n"
	sudo xbps-install -Svy firefox
	printf "\n\nInstalling a system diagnostics tool\n"
	sudo xbps-install -Svy inxi
	printf "\n\nInstalling a tool that restores iptables rules on boot\n"
	sudo xbps-install -Svy runit-iptables
	printf "\n\nInstalling an Internet utility suite\n"
	sudo xbps-install -Svy inetutils
	printf "\n\nInstalling  the Socklog logger\n"
	sudo xbps-install -Svy socklog
	printf "\n\nInstalling Void Linux config for Socklog\n"
	sudo xbps-install -Svy socklog-void
        printf "\n\nInstalling a suite for debugging and profiling programs\n"
        sudo xbps-install -Svy valgrind
        printf "\n\nInstalling Radare2, a hex editor, dissambler and debugger\n"
        sudo xbps-install -Svy radare2
        printf "\n\nInstalling ired, Interactice raw editor\n"
        sudo xbps-install -Svy ired
        printf "\n\nInstalling Cutter, a GUI for Radare2\n"
        sudo xbps-install -Svy cutter
        printf "\n\nInstalling a collection of tools for use with XBPS\n"
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

configureHomeEnvironment()
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

    if [[ -f $HOME/.asoundrc ]] ; then
        rm $HOME/.asoundrc
        echo "Deleted existing .asoundrc\n\n"
        ln -s $HOME/.config/AUDIO_CONFIG $HOME/.asoundrc
        echo "Created new symbolic link -> .asoundrc"
    
    else
        ln -s $HOME/.config/AUDIO_CONFIG $HOME/.asoundrc
        echo "Created new symbolic link -> .asoundrc"
    fi

    if [[ -f $HOME/.vimrc ]] ; then
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
}

usersAndGroups()
{ 
    #Adding the user to the socklog group
}

sourceBashrc()
{ 
    echo "Updating .bashrc\n\n"
    . ~/.bashrc
}

doFirewallConfig()
{
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

    #Apply rulesets to iptables
    . ~/.config/bash/iptables_ruleset.sh
    sudo iptables-save | sudo tee /etc/iptables/iptables.rules
    
    #ip6tables
    . ~/.config/bash/ip6tables_ruleset.sh
    sudo ip6tables-save | sudo tee /etc/iptables/ip6tables.rules
}

doSocklogConfig()
{
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
    sudo usermod -aG socklog $USER

}

#Call the functions above...
doPackageInstall
createDirectories
configureHomeEnvironment
doFireWallconfig
#doSocklogConfig
sourceBashrc
