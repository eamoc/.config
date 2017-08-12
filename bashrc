# Load the source controlled config files
#. ~/bin/dotfiles/bash/env
#. ~/bin/dotfiles/bash/config
#. ~/bin/dotfiles/bash/aliases

# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/bin/dotfiles/bash/aliases ]; then
    . ~/bin/dotfiles/bash/aliases
fi

if [ -f ~/bin/dotfiles/bash/config ]; then
    . ~/bin/dotfiles/bash/config
fi

if [ -f ~/bin/dotfiles/bash/env ]; then
    . ~/bin/dotfiles/bash/env   
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

