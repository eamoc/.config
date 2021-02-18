
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


