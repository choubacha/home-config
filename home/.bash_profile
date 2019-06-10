[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

if [ -x "$(command -v rbenv)" ];
then
  eval "$(rbenv init -)"
fi

if [ -f $HOME/.git-completion.bash ];
then
  source $HOME/.git-completion.bash
fi

if [ -f $(brew --prefix)/etc/bash_completion ]; then
  . $(brew --prefix)/etc/bash_completion
fi
export PATH=$PATH:/Applications/Postgres.app/Contents/Versions/9.4/bin
export PATH=$PATH:$HOME/bin
export PATH=$PATH:$HOME/.cargo/bin

# Setup tty for GPG
export GPG_TTY=$(tty)

# Setup NPM from .npmrc
if [ -f ~/.npmrc ]; then
  # Setup NPM from .npmrc
  export NPM_TOKEN=$(head -n 1 ~/.npmrc | sed -e 's|^//registry.npmjs.org/:_authToken=\(.*\)|\1|')
fi

if [ -d ~/.nvm ]; then
  export NVM_DIR="$HOME/.nvm"
  [ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh" # This loads nvm
fi

# Set up some defaults for editor
export EDITOR=vim

# Set up bash history
shopt -s histappend
shopt -s cmdhist
export HISTSIZE=1000000
export HISTFILESIZE=1000000
export HISTCONTROL=ignoreboth
export HISTIGNORE='ls:bg:fg:history'

complete -C aws_completer aws

# ALIASES
alias gg='git fetch origin && git log --graph --full-history --all --color  --remotes=origin --pretty=format:"%x1b[31m%h%x09%x1b[32m%d%x1b[0m%x20%s"'

# Aliasing vim because of brew installation
alias vim='/usr/local/bin/vim'

PROMPT_COMMAND=__prompt_command # Func to gen PS1 after CMDs

__prompt_command() {
  local EXIT="$?"             # This needs to be first

  # Flush the current history
  history -a

  local RCol='\[\e[0m\]'

  local Red='\[\e[0;31m\]'
  local Gre='\[\e[0;32m\]'
  local BYel='\[\e[1;33m\]'
  local BBlu='\[\e[1;34m\]'
  local Pur='\[\e[0;35m\]'

  PS1=""
  PS1+="\[\033[1;32m\]\u\[\033[0;37m\]@\[\033[1;34m\]\h:\W\[\033[0;37m\] => "

  if [ $EXIT -ne 0 ]; then
    PS1+="${Red}$EXIT${RCol}"      # Add red if exit code non 0
  else
    PS1+="${Gre}$EXIT${RCol}"
  fi

  PS1+="\n$ "
}

export PATH="$HOME/.cargo/bin:$PATH"

# Setting PATH for Python 3.6
# The original version is saved in .bash_profile.pysave
export PATH="/Library/Frameworks/Python.framework/Versions/3.6/bin:${PATH}"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

if [ -f $HOME/.bashrc ]
then
  . $HOME/.bashrc
fi
