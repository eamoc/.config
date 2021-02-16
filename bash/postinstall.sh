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
	print "Installing the X config merge tool\n\n"
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
        sudo xbps-install ired
        printf "Installing Cutter, a GUI for Radare2"
        xbps-install -Svy cutter

}

createDirectories()
{
    if [[ -d ${HOME}/tmp ]] ; then
        echo -e "The temporary directory $BOLD$HOME/tmp$RESET already exists. Skipping..."
    else
	mkdir $HOME/tmp
    fi


    if [[ -d ${HOME}/BACKUP ]] ; then
	echo -e "The temporary directory $BOLD$HOME/BACKUP$RESET already exists. Skipping..."
    else
	mkdir $HOME/BACKUP
    fi

    if [[ -d ${HOME}/void-packages ]] ; then
	echo -e "The temporary directory $BOLD$HOME/void-packages$RESET already exists. Skipping..."
    else
	echo -e "Setting the source packages Tree...."
	cd $HOME 
	git clone git://github.com/void-linux/void-packages.git
	cd void-packages
	./xbps-src binary-bootstrap
    fi
}

addSymbolicLinks()
{
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
        rm /var/service/iptables
        echo "Deleted existing symlink for iptables\n\n"
        ln -s /etc/sv/iptables /var/service 
        echo "Created new symbolic link -> /var/service/iptables"
    else
        ln -s /etc/sv/iptables /var/service
        echo "Created new symbolic link -> /var/service/iptables"
    fi


    if [[ -h /var/service/ip6tables ]] ; then
        rm /var/service/ip6tables
        echo "Deleted existing symlink for ipt6ables\n\n"
        ln -s /etc/sv/ip6tables /var/service 
        echo "Created new symbolic link -> /var/service/ip6tables"
    else
        ln -s /etc/sv/ip6tables /var/service
        echo "Created new symbolic link -> /var/service/ip6tables"
    fi

# Symbolic links for socklog

    if [[ -h /var/service/socklog-unix ]] ; then
        rm /var/service/socklog-unix
        echo "Deleted existing symlink for socklog-unix\n\n"
        ln -s /etc/sv/socklog-unix /var/service 
        echo "Created new symbolic link -> /var/service/socklog-unix"
    else
        ln -s /etc/sv/socklog-unix /var/service
        echo "Created new symbolic link -> /var/service/socklog-unix"
    fi


    if [[ -h /var/service/nanoklogd ]] ; then
        rm /var/service/nanoklogd
        echo "Deleted existing symlink for nanoklogd\n\n"
        ln -s /etc/sv/nanoklogd /var/service 
        echo "Created new symbolic link -> /var/service/nanoklogd"
    else
        ln -s /etc/sv/nanoklogd /var/service
        echo "Created new symbolic link -> /var/service/nanoklogd"
    fi

}

usersAndGroups()
{
    #Adding the user to the socklog group
    sudo usermod -aG $USER
}

#Call the functions above...
doPackageInstall
createDirectories
addSymbolicLinks
usersAndGroups

#-----------
#The Below will be implemented at a later date
#-----------

#Implement the dotfile environment
init_dotFileCheck()
{
	#Check whether it a first time use
	if [[ -z ${DOT_REPO} && -z ${DOT_DEST} ]]; then

		#Show first time setup menu
		initialSetup

	else
		#repo_check
		manage
		fi
}

initialSetup()
{
	echo -e "\n\nFirst time use, Set Up The Environment"
	echo -e "..........................................\n"
	read -p "Enter dotfiles repository URL : " -r DOT_REPO #Hint: It is usually called '.config'
	read -p "Where should $BOLD$(basename "${DOT_REPO}")$RESET be cloned to. (Defaults to ${HOME}): " -r DOT_DEST

	DOT_DEST=${DOT_DEST:-$HOME}

	#Cloning into a directory other than $HOME that already exists
	if [[ -d "$HOME/$DOT_DEST" ]]; then
		cloneRepo		
	
	#Cloning into a directory other than $HOME that does not exist, but will now be created	
	elif ! [[ -d "$HOME/$DOT_DEST" ]] &&  [[ $HOME != $DOT_DEST ]]; then 
		echo "Creating $BOLD$DOT_DEST$RESET..." 
		mkdir $HOME/$DOT_DEST
		cloneRepo		
	
	#Cloning into the $HOME Directory
	elif [[ $HOME = $DOT_DEST ]]; then
		cloneRepo
	
	else
		echo -e "\n$DOT_DEST Not a valid directory"
		exit 1
	fi
}

add_env()
{
	#export environment variables
	echo -e "\nExporting env variables DOT_DEST & DOT_REPO ..."

	current_shell=$(basename "$SHELL")

	if [[ $current_shell == "bash" ]]; then
		echo "export DOT_REPO=$DOT_REPO" >> "$HOME"/.bashrc
		echo "export DOT_DEST=$DOT_DEST" >> "$HOME"/.bashrc
	else
		echo "Couldn't export DOT_REPO and DOT_DEST."
		echo "Consider exporting them manually."
		exit 1
	fi

	echo -e "Configuration for $BOLD$current_shell$RESET has been updated."
}

#Display the configure options	
manage()
{
	while :
	do
		echo -e "\n[1] Show diff"
		echo -e "[2] Push changed dotfiles to remote"
		echo -e "[3] Pull latest changes from remote"
		echo -e "[4] List all dotfiles"
		echo -e "[q/Q] Quit Session"
		#Default choice is [1]
		read -p "What do you want me to do? [1]: " -n 1 -r USER_INPUT
		#See Parameter Expansion
		USER_INPUT=${USER_INPUT:-1}
		case $USER_INPUT in
			[1]* ) show_diff_check;;
			[2]* ) dot_push;;
			[3]* ) dot_pull;;
			[4]* ) find_dotfiles;;
			[q/Q]* ) echo -e "\n"; exit;;
			*)	printf "\n%s\n" "Invalid Input, Try Again";;
		esac
	done
}

#Locate all dotfiles in ${HOME}
find_dotfiles()
{
	printf "\n"
	readarray -t dotfiles < <( find "${HOME}" -maxdepth 1 -name ".*" -type f)
	printf '%s\n' "${dotfiles[@]}"
}

#Find all the dotfiles in the repo and compare them with the ones in ${HOME}
diff_check()
{
	if [[ -z $1 ]]; then
		declare -ag file_arr
	fi

	#dotfiles in repository
	readarray -t dotfiles_repo  < <( find "${HOME}/${DOT_DEST}/$(basename "${DOT_REPO}")" -maxdepth 1 -name ".*" -type f )

	# check length here ?
	for (( i=0; i<"${#dotfiles_repo[@]}"; i++))
	do
		dotfile_name=$(basename "${dotfiles_repo[$i]}")
		#Compare the HOME version of dotfile to that of repo
		diff=$(diff -u --supress-common-lines --color=always "${dotfile_repo[$i]}" "${HOME}/${dotfile_name}")
		if [[ $diff != "" ]]; then
			if [[ $1 == "show" ]]; then
				printf "\n\n%s" "Running diff between ${HOME}/${dotfile_name} and "
				printf "%s\n" "${dotfiles_repo[$i]}"
				printf "%s\n\n" "$diff"
			fi
			file_arr+=("${dotfile_name}")
		fi
	done
	if [[ ${#file_arr} == 0 ]]; then
		echo -e "\n\nNo Changes in dotfiles."
		return
	fi
}

show_diff_check()
{
    diff_check "show"
}

goodbye()
{
    echo "Goodbye!"
    exit
}
	

cloneRepo()
{
    if [[ "$HOME" = "$DOT_DEST" ]]; then
				
        #Clone the repository in the home directory
	if git -C "${HOME}" clone "${DOT_REPO}"; then
		add_env "$DOT_REPO" "$DOT_DEST"
		echo -e "\nEnvironment properly configured"
		goodbye
	fi

    elif [[ "$HOME" != "$DOT_DEST" ]]; then
		
	#Clone the repository in the destination directory
	if git -C "${HOME}/${DOT_DEST}" clone "${DOT_REPO}"; then
		add_env "$DOT_REPO" "$DOT_DEST"
		echo -e "\nEnvironment properly configured"
		goodbye
	fi
	
    else
	#Invalid arguments to exit, Repository not found
	echo -e "\n$DOT_REPO Unavailable, exiting"
	exit 1
	echo -e "The source packages tree is already set up.\n"
    fi
}


