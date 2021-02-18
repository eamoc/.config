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
	printf "\n\nInstalling the $BOLDXorg server, input drivers and a few additional utilities$RESET\n"
	sudo xbps-install -Svy xorg-minimal
	printf "\n\nInstalling $BOLDBasic font files and font encoding utilites$RESET\n"
	sudo xbps-install -Svy xorg-fonts	
	printf "\n\nInstalling $BOLDxterm emulator$RESET\n"
	sudo xbps-install -Svy xterm					
	printf "\n\nInstalling $BOLDclock for twm$RESET\n"
	sudo xbps-install -Svy clock				
	printf "\n\nInstalling $BOLDbasic window wanager$RESET\n"
	sudo xbps-install -Svy twm					
	printf "\n\nInstalling $BOLDTerminal multiplexer$RESET\n"
	sudo xbps-install -Svy tmux					
	printf "\n\nInstalling $BOLDAMD video driver$RESET\n" 
	sudo xbps-install -Svy xf86-video-amdgpu
	printf "\n\nInstalling $BOLDSource code control versioning system$RESET\n"
	sudo xbps-install -Svy git				
	printf "\n\nInstalling $BOLDTHE text editor :-)$RESET\n"
	sudo xbps-install -Svy vim				
	printf "\n\nInstalling $BOLDlocation db and lookup utilities$RESET\n"
	sudo xbps-install -Svy mlocate			
	printf "\n\nInstalling $BOLDa simple image viewer$RESET\n"
	udo xbps-install -Svy feh				
	printf "\n\nInstalling $BOLDa utility for displaying window and font properties in an X server$RESET\n"
	sudo xbps-install -Svy xprop				
	printf "\n\nInstalling $BOLDa utility that sets the size orientation and/or the reflection of the outputs for a screen.$RESET\n"
	sudo xbps-install -Svy xrandr			
	printf "\n\nInstalling $BOLDa visual front end for arandr$RESET\n"
	sudo xbps-install -Svy arandr			
	printf "\n\nInstalling $BOLDrxvt-unicode terminal editor$RESET\n"
	sudo xbps-install -Svy rxvt-unicode			
	printf "\n\nInstalling $BOLDGNU compiler and associated development utilities$RESET\n"
	sudo xbps-install -Svy base-devel			
	printf "\n\nInstalling $BOLDIRC chat client$RESET\n"
	sudo xbps-install -Svy irssi					
	printf "\n\nInstalling $BOLDGraphic image manipulation program$RESET\n"
	sudo xbps-install -Svy gimp				
	printf "\n\nInstalling $BOLDtext based music player$RESET\n"
	sudo xbps-install -Svy cmus					
	printf "\n\nInstalling $BOLDGUI based bittorrent client$RESET\n"
	sudo xbps-install -Svy qbittorrent				
	printf "\n\nInstalling $BOLDAdvanced Linux Sound Architercture files and utilities$RESET\n"
	sudo xbps-install -Svy alsa-utils				
	printf "\n\nInstalling $BOLDCurl command line downloading tool$RESET\n"
	sudo xbps-install -Svy curl				
	printf "\n\nInstalling $BOLDWget. It's similar to Curl$RESET\n" 
	sudo xbps-install -Svy wget					
	printf "\n\nInstalling $BOLDdropbox.$RESET\n"
	sudo xbps-install -Svy dropbox
	printf "\n\nInstalling $BOLDPython.$RESET\n"
	sudo xbps-install -Svy python
	printf "\n\nInstalling $BOLDCronie$RESET\n"
	sudo xbps-install -Svy cronie
	printf "\n\nInstalling $BOLDOpenBox Desktop Environment$RESET\n"
	sudo xbps-install -Svy openbox
	printf "\n\nInstalling $BOLDthe X config merge tool$RESET\n"
	sudo xbps-install -Svy xrdb
	printf "\n\nInstalling $BOLDa utility for modifying keymaps and pointer button mappings in X$RESET\n"
	sudo xbps-install -Svy xmodmap
	printf "\n\nInstalling $BOLDthe Firefox Web Browser$RESET\n"
	sudo xbps-install -Svy firefox
	printf "\n\nInstalling $BOLDa system diagnostics tool$RESET\n"
	sudo xbps-install -Svy inxi
	printf "\n\nInstalling $BOLDa tool that restores iptables rules on boot$RESET\n"
	sudo xbps-install -Svy runit-iptables
	printf "\n\nInstalling an $BOLDInternet utility suite$RESET\n"
	sudo xbps-install -Svy inetutils
	printf "\n\nInstalling  the $BOLDSocklog logger$RESET\n"
	sudo xbps-install -Svy socklog
	printf "\n\nInstalling $BOLDVoid Linux config for Socklog$RESET\n"
	sudo xbps-install -Svy socklog-void
        printf "\n\nInstalling $BOLDa suite for debugging and profiling programs$RESET\n"
        sudo xbps-install -Svy valgrind
        printf "\n\nInstalling $BOLDRadare2, a hex editor, dissambler and debugger$RESET\n"
        sudo xbps-install -Svy radare2
        printf "\n\nInstalling $BOLDired, Interactice raw editor$RESET\n"
        sudo xbps-install -Svy ired
        printf "\n\nInstalling $BOLDCutter, a GUI for Radare2$RESET\n"
        sudo xbps-install -Svy cutter
        printf "\n\nInstalling $BOLDa collection of tools for use with XBPS$RESET\n"
        sudo xbps-install -Svy xtools
}

createDirectories()
{
    if [[ -d $HOME/tmp ]] ; then
        printf "The directory $BOLD$HOME/tmp$RESET already exists. Skipping..."
    else
	mkdir $HOME/tmp
    fi

    if [[ -d $HOME/sCrAtCh ]] ; then
	printf "The directory $BOLD$HOME/sCrAtCh$RESET already exists. Skipping..."
    else
	mkdir $HOME/sCrAtCh
    fi

    if [[ -d $HOME/BACKUP ]] ; then
	printf "The directory $BOLD$HOME/BACKUP$RESET already exists. Skipping..."
    else
	mkdir $HOME/BACKUP
    fi

    if [[ -d $HOME/void-packages ]] ; then
	printf "The directory $BOLD$HOME/void-packages$RESET already exists. Skipping..."
    else
	printf "Setting up the source packages Tree...."
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
        printf "Deleted existing .bashrc\n\n"
        ln -s $HOME/.config/BASHRC $HOME/.bashrc
        printf "Created new symbolic link -> .bashrc\n\n"
  
    else
        ln -s $HOME/.config/BASHRC $HOME/.bashrc
        printf "Created new symbolic link -> .bashrc\n\n"
    fi
    
    if [[ -f $HOME/.xinitrc ]] ; then
        rm $HOME/.xinitrc
        printf "Deleted existing .xinitrc\n\n"
        ln -s $HOME/.config/XINITRC $HOME/.xinitrc
        printf "Created new symbolic link -> .xinitrc\n\n"
  
    else
        ln -s $HOME/.config/XINITRC $HOME/.xinitrc
        printf "Created new symbolic link -> .xinitrc\n\n"
    fi

    if [[ -f $HOME/.Xresources ]] ; then
        rm $HOME/.Xresources
        printf "Deleted existing .Xresources\n\n"
        ln -s $HOME/.config/XRESOURCES $HOME/.Xresources
        printf "Created new symbolic link -> .Xresources\n\n"

    else
        ln -s $HOME/.config/XRESOURCES $HOME/.Xresources
        printf "Created new symbolic link -> .Xresources\n\n"
    fi

    if [[ -f $HOME/.asoundrc ]] ; then
        rm $HOME/.asoundrc
        printf "Deleted existing .asoundrc\n\n"
        ln -s $HOME/.config/AUDIO_CONFIG $HOME/.asoundrc
        printf "Created new symbolic link -> .asoundrc\n\n"
    
    else
        ln -s $HOME/.config/AUDIO_CONFIG $HOME/.asoundrc
        printf "Created new symbolic link -> .asoundrc\n\n"
    fi

    if [[ -f $HOME/.vimrc ]] ; then
        rm $HOME/.vimrc
        printf "Deleted existing .vimrc\n\n"
        ln -s $HOME/.config/VIM_RC $HOME/.vimrc
        printf "Created new symbolic link -> .vimrc\n\n"
    
    else
        ln -s $HOME/.config/VIM_RC $HOME/.vimrc
        printf "Created new symbolic link -> .vimrc\n\n"
    fi
   
    if [[ -d /usr/share/X11/xorg.conf.d/ ]] ; then
        printf "Setting up Irish keyboard locale\n"
        sudo ln -s $HOME/.config/IRISH_XORG_LOCALE /usr/share/X11/xorg.conf.d/20-keyboard.conf
    fi
}

sourceBashrc()
{ 
    printf "Updating .bashrc\n\n"
    . ~/.bashrc
}

doFirewallConfig()
{
    # Adding symbolic links for iptables and ip6tables I.e enabling the services

    if [[ -h /var/service/iptables ]] ; then
        sudo rm /var/service/iptables
        printf "Deleted existing symlink for iptables\n\n"
        sudo ln -s /etc/sv/iptables /var/service 
        printf "Created new symbolic link -> /var/service/iptables\n\n"
    else
        sudo ln -s /etc/sv/iptables /var/service
        printf "Created new symbolic link -> /var/service/iptables\n\n"
    fi

    if [[ -h /var/service/ip6tables ]] ; then
        sudo rm /var/service/ip6tables
        printf "Deleted existing symlink for ipt6ables\n\n"
        sudo ln -s /etc/sv/ip6tables /var/service 
        printf "Created new symbolic link -> /var/service/ip6tables\n\n"
    else
        sudo ln -s /etc/sv/ip6tables /var/service
        printf "Created new symbolic link -> /var/service/ip6tables\n\n"
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
        printf "Deleted existing symlink for socklog-unix\n\n"
        sudo ln -s /etc/sv/socklog-unix /var/service 
        printf "Created new symbolic link -> /var/service/socklog-unix"
    else
        sudo ln -s /etc/sv/socklog-unix /var/service
        printf "Created new symbolic link -> /var/service/socklog-unix"
    fi

    if [[ -h /var/service/nanoklogd ]] ; then
        sudo rm /var/service/nanoklogd
        printf "Deleted existing symlink for nanoklogd\n\n"
        sudo ln -s /etc/sv/nanoklogd /var/service 
        printf "Created new symbolic link -> /var/service/nanoklogd"
    else
        sudo ln -s /etc/sv/nanoklogd /var/service
        printf "Created new symbolic link -> /var/service/nanoklogd"
    fi
    sudo usermod -aG socklog $USER
}

registerGit()
{
 printf "Registering the git user\n\n"
 git config --global user.email $GIT_AUTHOR_EMAIL
 git config --global user.name  $GIT_AUTHOR_NAME
}

#Call the functions above...
doPackageInstall
createDirectories
configureHomeEnvironment
sourceBashrc
registerGit
doFirewallConfig
#doSocklogConfig
