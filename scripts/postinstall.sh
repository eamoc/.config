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
	printf "\n\nInstalling the $FG_ORANGEXorg server, input drivers and a few additional utilities$RESET\n"
	sudo xbps-install -Sy xorg-minimal
	printf "\n\nInstalling $FG_ORANGEBasic font files and font encoding utilites$RESET\n"
	sudo xbps-install -Sy xorg-fonts	
	printf "\n\nInstalling $FG_ORANGExterm emulator$RESET\n"
	sudo xbps-install -Sy xterm					
	printf "\n\nInstalling $FG_ORANGEclock for twm$RESET\n"
	sudo xbps-install -Sy clock				
	printf "\n\nInstalling $FG_ORANGEbasic window wanager$RESET\n"
	sudo xbps-install -Sy twm					
	printf "\n\nInstalling $FG_ORANGETerminal multiplexer$RESET\n"
	sudo xbps-install -Sy tmux					
	printf "\n\nInstalling $FG_ORANGEAMD video driver$RESET\n" 
	sudo xbps-install -Sy xf86-video-amdgpu
	printf "\n\nInstalling $FG_ORANGESource code control versioning system$RESET\n"
	sudo xbps-install -Sy git				
	printf "\n\nInstalling $FG_ORANGETHE text editor :-)$RESET\n"
	sudo xbps-install -Sy vim				
	printf "\n\nInstalling $FG_ORANGElocation db and lookup utilities$RESET\n"
	sudo xbps-install -Sy mlocate			
	printf "\n\nInstalling $FG_ORANGEa simple image viewer$RESET\n"
	udo xbps-install -Sy feh				
	printf "\n\nInstalling $FG_ORANGEa utility for displaying window and font properties in an X server$RESET\n"
	sudo xbps-install -Sy xprop				
	printf "\n\nInstalling $FG_ORANGEa utility that sets the size orientation and/or the reflection of the outputs for a screen.$RESET\n"
	sudo xbps-install -Sy xrandr			
	printf "\n\nInstalling $FG_ORANGEa visual front end for arandr$RESET\n"
	sudo xbps-install -Sy arandr			
	printf "\n\nInstalling $FG_ORANGErxvt-unicode terminal editor$RESET\n"
	sudo xbps-install -Sy rxvt-unicode			
	printf "\n\nInstalling $FG_ORANGEGNU compiler and associated development utilities$RESET\n"
	sudo xbps-install -Sy base-devel			
	printf "\n\nInstalling $FG_ORANGEIRC chat client$RESET\n"
	sudo xbps-install -Sy irssi					
	printf "\n\nInstalling $FG_ORANGEGraphic image manipulation program$RESET\n"
	sudo xbps-install -Sy gimp				
	printf "\n\nInstalling $FG_ORANGEtext based music player$RESET\n"
	sudo xbps-install -Sy cmus					
	printf "\n\nInstalling $FG_ORANGEGUI based bittorrent client$RESET\n"
	sudo xbps-install -Sy qbittorrent				
	printf "\n\nInstalling $FG_ORANGEAdvanced Linux Sound Architercture files and utilities$RESET\n"
	sudo xbps-install -Sy alsa-utils				
	printf "\n\nInstalling $FG_ORANGECurl command line downloading tool$RESET\n"
	sudo xbps-install -Sy curl				
	printf "\n\nInstalling $FG_ORANGEWget. It's similar to Curl$RESET\n" 
	sudo xbps-install -Sy wget					
	printf "\n\nInstalling $FG_ORANGEdropbox.$RESET\n"
	sudo xbps-install -Sy dropbox
	printf "\n\nInstalling $FG_ORANGEPython.$RESET\n"
	sudo xbps-install -Sy python
	printf "\n\nInstalling $FG_ORANGECronie$RESET\n"
	sudo xbps-install -Sy cronie
	printf "\n\nInstalling $FG_ORANGEOpenBox Desktop Environment$RESET\n"
	sudo xbps-install -Sy openbox
	printf "\n\nInstalling $FG_ORANGEthe X config merge tool$RESET\n"
	sudo xbps-install -Sy xrdb
	printf "\n\nInstalling $FG_ORANGEa utility for modifying keymaps and pointer button mappings in X$RESET\n"
	sudo xbps-install -Sy xmodmap
	printf "\n\nInstalling $FG_ORANGEthe Firefox Web Browser$RESET\n"
	sudo xbps-install -Sy firefox
	printf "\n\nInstalling $FG_ORANGEa system diagnostics tool$RESET\n"
	sudo xbps-install -Sy inxi
	printf "\n\nInstalling $FG_ORANGEa tool that restores iptables rules on boot$RESET\n"
	sudo xbps-install -Sy runit-iptables
	printf "\n\nInstalling an $FG_ORANGEInternet utility suite$RESET\n"
	sudo xbps-install -Sy inetutils
        printf "\n\nInstalling $FG_ORANGEA suite for debugging and profiling programs$RESET\n"
        sudo xbps-install -Sy valgrind
        printf "\n\nInstalling $FG_ORANGERadare2, a hex editor, dissambler and debugger$RESET\n"
        sudo xbps-install -Sy radare2
        printf "\n\nInstalling $FG_ORANGEired, Interactive raw editor$RESET\n"
        sudo xbps-install -Sy ired
        printf "\n\nInstalling $FG_ORANGECutter, a GUI for Radare2$RESET\n"
        sudo xbps-install -Sy cutter
        printf "\n\nInstalling $FG_ORANGEa collection of tools for use with XBPS$RESET\n"
        sudo xbps-install -Sy xtools
        printf "\n\nInstalling $FG_ORANGEVLC Media Player$RESET\n"
        sudo xbps-install -Sy vlc 
        printf "\n\nInstalling $FG_ORANGEffmpeg video and audio converter$RESET\n"
        sudo xbps-install -Sy ffmpeg 
        printf "\n\nInstalling $FG_ORANGEAudacity audio editor$RESET\n"
        sudo xbps-install -Sy audacity
        printf "\n\nInstalling $FG_ORANGEJSON Processor jq$RESET\n" 
        sudo xbps-install -Sy jq
        printf "\n\nInstalling $FG_ORANGEXClip and XClipboard$RESET\n" 
        sudo xbps-install -Sy xclip xclipboard
        printf "\n\nInstalling $FG_ORANGE$A tool the lists open files$RESET\n" 
        sudo xbps-install -Sy lsof
        printf "\n\nInstalling $FG_ORANGE$A terminal browser for the gemini protocol$RESET\n" 
        sudo xbps-install -Sy amfora
        printf "\n\nInstalling $FG_ORANGE$A disk encryption utility$RESET\n" 
        sudo xbps-install -Sy cryptsetup
        printf "\n\nInstalling $FG_ORANGE$The Keybase filesystem$RESET\n" 
        sudo xbps-install -Sy kbfs
        printf "\n\nInstalling $FG_ORANGE$The keybase.io command line client$RESET\n" 
        sudo xbps-install -Sy keybase
        printf "\n\nInstalling $FG_ORANGE$Logical Volume Manager 2 utilities$RESET\n" 
        sudo xbps-install -Sy lvm2
        printf "\n\nInstalling $FG_ORANGE$Tool for managing/monitoring Linux md device arrays$RESET\n" 
        sudo xbps-install -Sy mdadm
        printf "\n\nInstalling $FG_ORANGE$$Command-line tools for building TCP client-server applications$RESET\n" 
        sudo xbps-install -Sy ucspi
        printf "\n\nInstalling $FG_ORANGENetwork protocol analyzer$RESET\n" 
        sudo xbps-install -Sy wireshark
        printf "\n\nInstalling $FG_ORANGEC/C++ Package manager$RESET\n" 
        sudo xbps-install -Sy clib

}

createDirectories()
{
    if [[ -d $HOME/tmp ]] ; then
        printf "The directory $FG_ORANGE$HOME/tmp$RESET already exists. Skipping..."
    else
	mkdir $HOME/tmp
    fi

    if [[ -d $HOME/sCrAtCh ]] ; then
	printf "The directory $FG_ORANGE$HOME/sCrAtCh$RESET already exists. Skipping..."
    else
	mkdir $HOME/sCrAtCh
    fi

#    if [[ -d $HOME/BACKUP ]] ; then
#	printf "The directory $FG_ORANGE$HOME/BACKUP$RESET already exists. Skipping..."
#    else
#	mkdir $HOME/BACKUP
#    fi

    if [[ -d $HOME/void-packages ]] ; then
	printf "The directory $FG_ORANGE$HOME/void-packages$RESET already exists. Skipping..."
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
    printf "Reloading .bashrc\n\n"
    . $HOME/.bashrc
}

gitGlobalIDSetup()
{
    #Adding global username and email to git
    printf "Adding global username and email to git\n\n"
    git config --global user.name "eamonn costello"
    git config --global user.email "eamonncostello@gmail.com"
}

doFirewallConfig()
{
    #If the service already exists, disable it
    if [ -L /var/service/iptables ] ; then
       sudo rm /var/service/iptables
       printf "Deleted existing symlink for iptables\n\n"
    fi

    if [ -L /var/service/ip6tables ] ; then
       sudo rm /var/service/ip6tables
       printf "Deleted existing symlink for ipt6ables\n\n"
    fi

    #Apply rulesets to iptables and ip6tables
    if [ -f $HOME/.config/scripts/iptables_ruleset.sh ] ; then
       sudo sh $HOME/.config/scripts/iptables_ruleset.sh
       sudo iptables-save | sudo tee /etc/iptables/iptables.rules
       printf "Finished applying ruleset to iptables\n\n"
    else 
       printf "Ruleset file does not exist\n\n"    
    fi

    if [ -f $HOME/.config/scripts/ip6tables_ruleset.sh ] ; then
       sudo sh $HOME/.config/scripts/ip6tables_ruleset.sh
       sudo ip6tables-save | sudo tee /etc/iptables/ip6tables.rules
       printf "Finished applying ruleset to ip6tables\n\n"
    else 
       printf "Ruleset file does not exist\n\n"
    fi

    # Add symbolic links for iptables and ip6tables I.e enable the services
    sudo ln -s /etc/sv/iptables /var/service 
    printf "Enabled the iptables service\n\n"
    sudo ln -s /etc/sv/ip6tables /var/service 
    printf "Enabled the ip6tables service\n\n"
}

doSocklogConfig()
{
    printf "\n\nInstalling  the $FG_ORANGESocklog logger$RESET\n"
    sudo xbps-install -Sy socklog
    printf "\n\nInstalling $FG_ORANGEVoid Linux config for Socklog$RESET\n"
    sudo xbps-install -Sy socklog-void

    #Add a log user for logging
#   useradd -M -N -g 99 -u 98 -c 'Unprivileged User' -d /dev/null -s /bin/false log
    
    #Give the logged in user access to the socklog group (dont know why I need this)
    sudo usermod -aG socklog $USER
   
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
}



#Call the functions above...
doSocklogConfig
doPackageInstall
createDirectories
configureHomeEnvironment
doFirewallConfig
gitGlobalIDSetup
sourceBashrc

