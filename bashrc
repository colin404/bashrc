# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# Settings
stty -ixon

# 历史记录优化
HISTSIZE=5000               # 内存中保存的历史记录数量
HISTFILESIZE=10000          # 历史文件最大行数
HISTCONTROL=ignoreboth      # 忽略重复命令和空格开头的命令
HISTIGNORE="ls:bg:fg:history:clear"   # 忽略杂项命令
shopt -s histappend         # 追加历史记录而非覆盖
#PROMPT_COMMAND="history -a; history -c; history -r; $PROMPT_COMMAND"
# 每次命令后立即写入历史文件，跨会话同步

# 终端颜色支持
export TERM=xterm-256color

# User specific environment
# Basic envs
export WORKSPACE="$HOME/workspace"
# 语言设置（解决终端中文乱码）
export LANG="en_US.UTF-8"
export LC_ALL=en_US.UTF-8
export PS1="[\u@dev \W]\$ "
export EDITOR=nvim

# 系统命令简化
alias ll='ls -alFh --color=auto'
alias la='ls -A'
alias ls='ls --color=auto'
alias grep='grep --color=auto'
#alias rm='rm -i'            # 删除前确认
alias cp='cp -i'
alias mv='mv -i'
alias vi='nvim'

# PATH env
export PATH="$HOME/bin:$HOME/.local/bin:/usr/local/bin:/usr/libexec/git-core:$PATH"

# Go envs
export GOVERSION=go1.24.3 # Go 版本设置
export GO_INSTALL_DIR=$HOME/go
export GOROOT=$GO_INSTALL_DIR/$GOVERSION
export GOPATH=$WORKSPACE/golang
export PATH=$GOROOT/bin:$GOPATH/bin:$PATH # 添加 PATH 路径
export GOPROXY=https://goproxy.cn,direct
export GOPRIVATE=github.com
#export GOTOOLCHAIN=go1.24.3+auto
export GOSUMDB=off
#export GOPROXY="https://goproxy.io"
#export GOPROXY=https://proxy.golang.org,direct
export GOSRC="$WORKSPACE/golang/src"

# Other envs
export ETCDCTL_API=3

# tabtab source for packages
# uninstall by removing these lines
[ -f ~/.config/tabtab/__tabtab.bash ] && . ~/.config/tabtab/__tabtab.bash || true

############################################################
# 4. 实用函数
############################################################
# 一键创建目录并进入
mkcd() {
  mkdir -p "$1" && cd "$1"
}

# 解压万能函数
extract () {
  if [ -f "$1" ]; then
      case "$1" in
          *.tar.bz2) tar xjf "$1"  ;;
          *.tar.gz)  tar xzf "$1"  ;;
          *.bz2)     bunzip2 "$1"  ;;
          *.rar)     unrar x "$1"  ;;
          *.gz)      gunzip "$1"   ;;
          *.tar)     tar xf "$1"   ;;
          *.tbz2)    tar xjf "$1"  ;;
          *.tgz)     tar xzf "$1"  ;;
          *.zip)     unzip "$1"    ;;
          *.Z)       uncompress "$1" ;;
          *.7z)      7z x "$1"     ;;
          *) echo "无法解压 '$1'" ;;
      esac
  else
      echo "'$1' 不是有效文件"
  fi
}

if [ -f $HOME/.config/bashrc/completion ]; then
	. $HOME/.config/bashrc/completion
fi

if [ -f $HOME/.config/bashrc/alias ]; then
	. $HOME/.config/bashrc/alias
fi
