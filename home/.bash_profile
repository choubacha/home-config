[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*
if [ -f $HOME/.bashrc ]
then
  . $HOME/.bashrc
fi
if [ -f $(brew --prefix)/etc/bash_completion ]; then
  . $(brew --prefix)/etc/bash_completion
fi
export PATH=$PATH:/Applications/Postgres.app/Contents/Versions/9.4/bin
export PATH=$PATH:$HOME/bin
export PATH=$PATH:$HOME/.cargo/bin

# Setup NPM from .npmrc
export NPM_TOKEN=$(head -n 1 ~/.npmrc | sed -e 's|^//registry.npmjs.org/:_authToken=\(.*\)|\1|')

complete -C aws_completer aws

# ALIASES
alias dockerclear='docker rm $(docker ps -aq --filter="status=exited"); docker rmi $(docker images -q --filter="dangling=true")'
alias gg='git fetch origin && git log --graph --full-history --all --color  --remotes=origin --pretty=format:"%x1b[31m%h%x09%x1b[32m%d%x1b[0m%x20%s"'

PROMPT_COMMAND=__prompt_command # Func to gen PS1 after CMDs

__prompt_command() {
  local EXIT="$?"             # This needs to be first

  local RCol='\[\e[0m\]'

  local Red='\[\e[0;31m\]'
  local Gre='\[\e[0;32m\]'
  local BYel='\[\e[1;33m\]'
  local BBlu='\[\e[1;34m\]'
  local Pur='\[\e[0;35m\]'

  PS1=""
  PS1+="\[\033[1;32m\]\u\[\033[0;37m\]@\[\033[1;34m\]\h:\W\[\033[0;37m\] => "

  if [ $EXIT != 0 ]; then
    PS1+="${Red}$EXIT${RCol}"      # Add red if exit code non 0
  else
    PS1+="${Gre}0${RCol}"
  fi

  PS1+="\n$ "
}

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh" # This loads nvm

cp-from-docker () {
  docker-compose run web cat $1 > $1
}

dc-web () {
  docker-compose run web "$@"
}

dc-test () {
  docker-compose run -e RAILS_ENV=test web "$@"
}

git-delete-local-branches () {
  branch=${1:-"master"}
  git branch --merged $branch | grep -v "\* $branch" | xargs -n 1 git branch -d
}

git-delete-local-branches-all () {
  branch=${1:-"master"}
  git branch $branch | grep -v "\* $branch" | xargs -n 1 git branch -D
}

export PATH="$HOME/.cargo/bin:$PATH"