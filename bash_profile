# .bash_profile

# Get the aliases and functions
if [ -f ~/.bashrc ]; then
	. ~/.bashrc
fi

# User specific environment and startup programs

PATH=$PATH:$HOME/.local/bin:$HOME/bin

export PATH

#Virtual enviroments 
export WORKON_HOME="$HOME/.virtualenvs"
source "/usr/local/bin/virtualenvwrapper.sh"

#Android sdk
export PATH=${PATH}:/Android/sdk/tools

