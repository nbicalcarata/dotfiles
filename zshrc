export DEFAULT_USER="user"
# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="robbyrussell"
#ZSH_THEME="gnzh"
#ZSH_THEME="bira"
#ZSH_THEME="nanotech"
#ZSH_THEME="fox"
#ZSH_THEME="jonathan"
#ZSH_THEME="juanghurtado"
#ZSH_THEME="mortalscumbag"
#ZSH_THEME="steeef"
#ZSH_THEME="wezm"
#ZSH_THEME="darkblood"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
#plugins=(git python tmux tmuxinator virtualenvwrapper)

source $ZSH/oh-my-zsh.sh


#El autocompletado esta roto!
#source ~/.bin/tmuxinator.zsh

#export PROJECT_HOME=$HOME/Proyectos

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/dsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

alias mux=tmuxinator
alias v="mux dev"
alias win7="sudo /usr/win7"
alias win10="sudo /usr/win10"
alias fed="sudo /usr/fed"

# So as not to be disturbed by Ctrl-S ctrl-Q in terminals:
stty -ixon

export NO_AT_BRIDGE=1

export TERM="xterm-256color"
export PATH="$PATH:$HOME/.config/composer/vendor/bin"
export NVIM_GTK_PREFER_DARK_THEME=1
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

alias gtypist=gtypist esp.typ

function homestead() {
    ( cd ~/Homestead && vagrant $* )
  }
