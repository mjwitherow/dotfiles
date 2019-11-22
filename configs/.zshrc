# Path to your oh-my-zsh installation.
autoload -U colors && colors
export CLICOLOR=1

# Uncomment the following line to display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# history command output
HIST_STAMPS="mm/dd/yyyy"

plugins=(git)

# Look in ~/.oh-my-zsh/themes/
ZSH_THEME="beartrap"

export ZSH=/Users/mattbook/.oh-my-zsh
export PATH="$PATH:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/bin"
source $ZSH/oh-my-zsh.sh

# Edit settings
alias zshconf="vim ~/.zshrc"
alias ohmyconf="vim ~/.oh-my-zsh"

# Need a custom key path?
# export SSH_KEY_PATH="~/.ssh/dsa_id"

# AWS
export AWS_CLI=/usr/local/bin/aws

# Docker (old)
#export DOCKER_TLS_VERIFY="1"
#export DOCKER_HOST="tcp://192.168.99.100:2376"
#export DOCKER_CERT_PATH="/Users/matt.witherow/.docker/machine/machines/dockerdevvm"
#export DOCKER_MACHINE_NAME="dockerdevvm"

# PostgresQL
alias pg-start='pg_ctl -D /usr/local/var/postgres -l /usr/local/var/postgres/server.log start'
alias pg-stop='pg_ctl -D /usr/local/var/postgres stop -s -m fast'

# TMUX
alias tma="tmux attach-session -t $1"
alias tmn="tmux new -s $1"
alias tml="tmux ls"
alias tmk="tmux kill-session -t $1"

# Shell into DCs quickly
# alias dc='ssh matt.witherow@org.com'

# Tricks
# Find & Replace All Instances 
alias frall="find $1 -type f -print0 | xargs -0 sed -i '' 's/$2/$3/g'"
alias ll='ls -la'

# MTR
alias mtr='sudo /usr/local/Cellar/mtr/0.86/sbin/mtr $1'
