#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# TMUX自動起動
if which tmux >/dev/null 2>&1 && export TERM=xterm-256color; then
  # if no session is started, start a new session
  test -z ${TMUX} && tmux

    # when quitting tmux, try to attach
    while test -z ${TMUX}; do
      tmux attach || break
    done
fi

alias dk='sudo docker'
alias dks='sudo docker-compose'
alias vim='vim -N'
alias ls='ls --color=auto'
alias zipalign=/home/hkt/Android/Sdk/build-tools/27.0.0/zipalign
alias kill='kill -s 9'
alias lampp='sudo /opt/lampp/lampp start'
alias search='node /home/hkt/openBrowserCommand/index.js'
#alias mysql='sudo /opt/lampp/bin/mysql'
alias mysqllog='cat /opt/lampp/etc/mysql.log'
alias row='wc -l `find ./ -name '\''*.php'\'' -o -name '\''*.js'\'' -o -name '\''*.css'\''`'
alias scss='php ~/scss_go/scss.php'
alias beep='beep -f 5000 -l 50 -r 2'
alias peco='percol --match-method="regex"'
alias giv='node /home/hkt/giv/built/index.js'
export PATH=/home/hkt/Android/Sdk/platform-tools:$PATH
export PATH=/home/hkt/Android/Sdk/tools:$PATH
export JAVA_HOME=/usr/lib/jvm/java-8-openjdk
export PATH=$PATH:$JAVA_HOME/bin
export PATH="$PATH:/root/.gem/ruby/2.5.0/bin"
export ANDROID_HOME=/home/hkt/Android/Sdk
export sdkmanager=28

function grep_replace() {
  grep -lr "${1}" # check
  grep -lr "${1}" | xargs -L 1 sed -i -e "s/${1}/${2}/g" # exec
}

function set_git_ssh_command() {
  user=($(git config remote.origin.url 2> /dev/null | awk -F":" '{print $2}' | awk -F"/" '{print $1}'))
  if [ ${#user[@]} -eq 1 ]; then
    key="git_${user[0]}_rsa"
    if [ -f ~/.ssh/${key} ]; then
      export GIT_SSH_COMMAND="ssh -i ~/.ssh/${key}"
    fi
  fi
}
alias sgit="set_git_ssh_command && git"

function get_git_arrow() {
  declare -a name=($(git rev-parse --abbrev-ref HEAD 2> /dev/null))
  if [ ${#name[@]} -gt 0 ]; then # ifの[]には必ず半角スペースを左右につける。でないとエラー
    printf " -> "
  fi
}
function get_git_branch_name() {
  declare -a name=($(git rev-parse --abbrev-ref HEAD 2> /dev/null))
  if [ ${#name[@]} -gt 0 ]; then # ifの[]には必ず半角スペースを左右につける。でないとエラー
    printf "${name[0]} "
  fi
}

PS1='[\u@\h \W]\[\e[;36m\]$(get_git_arrow)\[\e[m\]\[\e[1;36m\]$(get_git_branch_name)\[\e[m\]$ '
