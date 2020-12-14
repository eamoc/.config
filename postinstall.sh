#!/bin/bash
#Post-install Script for my void distribution

#Update the packages to the most recent version 

printf "\n\nUpdating packages to latest version\n\n"
sudo xbps-install -Suvy

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
	sudo xbps-install -Svy xfree86-video-amdgpu
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
	printf "\nInstalling a utility that sets the size orientation and/or the reflection of the outputs for a screen. It can also set the screen size\n\n"
	sudo xbps-install -Svy xrandr			
	printf "\nInstalling a visual front end for arandr\n\n"
	sudo xbps-install -Svy arandr			
	printf "\nInstalling xrvt-unicode terminal editor\n\n"
	sudo xbps-install -Svy xrvt-unicode			
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
	printf"\nInstalling fluxbox Desktop environment"
	sudo xbps-install -Svy fluxbox
}

#Setup the Source packages tree
doSourceTreeInit()
{
	printf "Setting up the source packages tree"
	cd ~
	git clone git://github.com/void-linux/void-packages.git
	cd void-packages
	./xbps-src binary-bootstrap
}

#Implememt the dotfile environment
init_dotFileCheck()
{
	#Check whether it a first time use
	if [[ -z ${DOT_REPO} && -z ${DOT_DEST} ]]; then
		#Show first time setup menu
		#inital setup
	else
		#repo_check
		#manage
		fi
}
initial_setup()
{
	echo -e "\n\nFirst time use, Set Up The Environment"
	echo -e "..........................................\n"
	read -p "Enter dotfiles repository URL : " -r DOT_REPO
	read -p "Where should the repo be cloned to $(basename "${DOT_REPO}") (${HOME}/..): " -r DOT_DEST
	DOT_DEST=${DOT_DEST:-$HOME}
	if [[ -d "$HOME/$DOT_DEST" ]]; then
		#Clone the repository in the destination directory
		if git -C "${HOME}/${DOT_DEST}" clone "${DOT_REPO}"; then
			add_env "$DOT_REPO" "$DOT_DEST"
			echo -e "\nEnvironment properly configured"
			goodbye
		else
			#invalid arguments to exit, Repostory not found
			echo -e "\n$DOT_REPO Unavailable, exiting"
			exit 1
		fi
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
	if [[ $current_shell == "zsh" ]]; then
		echo "export DOT_REPO=$1" >> "$HOME"/.zshrc"
		echo "export DOT_DEST=$1" >> "$HOME"/.zshrc"

	elif [[ $current_shell == "bash" ]]; then
		echo "export DOT_REPO=$1" >> "$HOME"/.bashrc"
		echo "export DOT_DEST=$1" >> "$HOME"/.bashrc"
	else
		echo "Couldn't export DOT_REPO and DOT_DEST."
		echo "Consider exporting them manually."
		exit 1
	fi
	echo -e "Configuration for SHELL: $current_shell has been updated."

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
			[q/Q]* ) exit;;
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
		if [[ $diff != ""]]; then
			if [[ $1 == "show" ]]; then
				printf "\n\n%s" "Running diff between ${HOME}/${dotfile_name} and "
				printf "%s\n\n" "${dotfiles_repo[$i]}"
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

