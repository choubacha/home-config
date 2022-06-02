export BASH_SILENCE_DEPRECATION_WARNING=1

# Switch to an arm64e shell by default
if [ `machine` != arm64e ]; then
  exec arch -arm64 bash -l
fi

export PATH=/opt/homebrew/bin:$PATH
export PATH=$PATH:$HOME/.cargo/bin
export PATH="$HOME/.cargo/bin:$PATH"

if [ -x "$(command -v rbenv)" ];
then
  export RUBY_CONFIGURE_OPTS="--with-openssl-dir=$(brew --prefix openssl@1.1)"
  export RUBY_CFLAGS="-Wno-error=implicit-function-declaration"
  export RBENV_ROOT=$(brew --prefix rbenv)
  export PATH=$RBENV_ROOT/bin:$PATH
  eval "$(rbenv init -)"
fi

if [ -d ~/.rvm ];
then
  source /Users/choubacha/.rvm/scripts/rvm
fi

if [ -f ~/.github_token ]; then
  export GITHUB_TOKEN=$(cat ~/.github_token)
else
  echo "No github token found in ~/.github_token"
fi

if [ -f $HOME/.git-completion.bash ];
then
  source $HOME/.git-completion.bash
fi

if [ -f $(brew --prefix)/etc/bash_completion ]; then
  . $(brew --prefix)/etc/bash_completion
fi

# Setup tty for GPG
export GPG_TTY=$(tty)

# Setup NPM from .npmrc
if [ -f ~/.npmrc ]; then
  # Setup NPM from .npmrc
  export NPM_TOKEN=$(head -n 1 ~/.npmrc | sed -e 's|^//registry.npmjs.org/:_authToken=\(.*\)|\1|')
fi

if [ -d ~/.nvm ]; then
  export NVM_DIR="$HOME/.nvm"
  [ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"  # This loads nvm
  [ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion
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
alias git-vim='vim -O $(echo $(git ls-files -m))'
alias git-rspec='rspec $(git ls-files -m | grep spec | tr "\n" " ")'

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

if [ -x "$(command -v direnv)" ]; then
  # Setup the .envrc reading
  eval "$(direnv hook bash)"
fi

[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

if [ -f $HOME/.bashrc ]
then
  . $HOME/.bashrc
fi

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*
