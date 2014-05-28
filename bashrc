# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

# User specific aliases and functions

[ -e /usr/bin/tracker-control ] && [ -x /usr/bin/tracker-control ] && /usr/bin/tracker-control -r > /dev/null
export MOZILLA_FIVE_HOME=/usr/lib/mozilla

# export TERM="gnome-terminal"
#PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME}: ${PWD/$HOME/~}\007"'

export PATH=/home/adrian/npm/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games
export NODE_PATH=:/home/adrian/npm/lib/node_modules

source /etc/bash_completion.d/virtualenvwrapper

source ~/.shell_prompt.sh
