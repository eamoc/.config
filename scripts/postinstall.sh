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


getEssentials()
{
    
	printf "\nDownloading some required packages\n\n"
	printf "\n\nInstalling the $FG_ORANGEHTTP based Download tool$RESET\n"
	sudo xbps-install -Sy wget
	printf "\n\nInstalling $FG_ORANGEVim Text Editor$RESET\n"
	sudo xbps-install -Sy vim
}

doPackageInstall()
{
        input="$HOME/.config/INSTALLED_PKGS"
        while read -r line
        do
             if ! [[ $line =~ "socklog"  || $line =~ "cronie" || $line =~ "wget" || $line =~ "git" || $line =~ "vim" ]]; then
                sudo xbps-install -Sy $line
                printf "\ninstalling " printf $line 
             fi
        done < "$input"
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

    if [[ -f $HOME/.bash_logout ]] ; then
        rm $HOME/.bash_logout 
        printf "Deleted existing .bash_logout \n\n"
        ln -s $HOME/.config/VIM_RC $HOME/.bash_logout 
        printf "Created new symbolic link -> .bash_logout \n\n"
    
    else
        ln -s $HOME/.config/VIM_RC $HOME/.bash_logout 
        printf "Created new symbolic link -> .bash_logout \n\n"
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

doCronieConfig()
{
    
    printf "\n\nInstalling  the $FG_ORANGEcronie daemon to run specified commands$RESET\n"
    sudo xbps-install -Sy cronie

   
    if [[ -h /var/service/cronie ]] ; then
        sudo rm /var/service/cronie
        printf "Deleted existing symlink for cronie\n"
        sudo ln -s /etc/sv/cronie /var/service 
        printf "Created new symbolic link -> /var/service/cronie\n"

        #Set up the crontab
        printf "importing crontab from file"
        crontab $HOME/.config/CRONTAB
    else
        sudo ln -s /etc/sv/cronie /var/service
        printf "Created new symbolic link -> /var/service/cronie\n"
        
        #Set up the crontab
        printf "importing crontab from file\n"
        crontab $HOME/.config/CRONTAB
    fi

}

doGoLangInstall()
{
        
    printf "\n\nDownloading and extracting $FG_ORANGEGoLang$RESET\n"
   # -4 means connect to ipv4 adresses only.
   # -O - Means print to standard output
    wget -c https://golang.org/dl/go1.16.linux-amd64.tar.gz -4 -O - | sudo tar -xz -C /usr/local/
}

doTelegramInstall()
{
  
    printf "\n\nDownloading and extracting $FG_ORANGETelegram$RESET\n"
    wget -c https://telegram.org/dl/desktop/linux -4 -O - | sudo tar xJ -C /opt
    sudo ln -sf /opt/Telegram/Telegram /usr/local/bin/telegram-desktop
}

doDiscordInstall()
{
    printf "\n\nDownloading and extracting $FG_ORANGEDiscord$RESET\n"
    wget -c https://discord.com/api/download?platform=linux&format=tar.gz -4 -O - | sudo tar xJ -C /opt
    sudo ln -sf /opt/Discord /usr/local/bin/Discord
}

doSucklessConfig()
{
    printf "Downloading sourcecode from suckless.org"
    git clone git://git.suckless.org/dwm /usr/src/dwm
    git clone git://git.suckless.org/st /usr/src/st
    git clone git://git.suckless.org/dmenu /usr/src/dmenu
}


#Call the functions above...
#getEssentials
#doSocklogConfig
#doCronieConfig
#doPackageInstall
#createDirectories
configureHomeEnvironment
#doFirewallConfig
#gitGlobalIDSetup
#sourceBashrc
#doGoLangInstall

