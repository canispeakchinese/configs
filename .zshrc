source ~/.zsh/plugins/zplug/init.zsh
# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH

# Path to your Oh My Zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time Oh My Zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="robbyrussell"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git z)

# History config
HISTSIZE=10000
SAVEHIST=10000
HISTFILE=~/.zsh_history

zplug "zsh-users/zsh-autosuggestions"
# Install packages that have not been installed yet
if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    else
        echo
    fi
fi
zplug load

source $ZSH/oh-my-zsh.sh

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# fzf-history-widget，实时搜索历史命令并替换输入内容
fzf-history-widget() {
  # 使用 history 获取命令历史，去掉编号部分并通过 fzf 进行实时搜索
  local selected
  selected=$(fc -rl 1 | sed 's/^[ ]*[0-9]\+[ ]*//' | fzf --height 40% --query="$LBUFFER" --no-sort)

  # 如果选中了一条命令，将其显示在命令行输入栏
  if [[ -n "$selected" ]]; then
    LBUFFER="$selected"  # 将选中的命令填入输入栏
    zle redisplay  # 重新绘制命令行
  fi
}
zle -N fzf-history-widget

# 绑定快捷键（例如 Ctrl+R）到 fzf-history-widget
bindkey '^R' fzf-history-widget

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='nvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch $(uname -m)"

# Set personal aliases, overriding those provided by Oh My Zsh libs,
# plugins, and themes. Aliases can be placed here, though Oh My Zsh
# users are encouraged to define aliases within a top-level file in
# the $ZSH_CUSTOM folder, with .zsh extension. Examples:
# - $ZSH_CUSTOM/aliases.zsh
# - $ZSH_CUSTOM/macos.zsh
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# go开发环境变量配置
export GOROOT=~/.go1.24.2
export GOPATH=~/my_code/go
export PATH=$GOROOT/bin:$PATH

# cpp开发环境变量配置
export PJPROJECT_HOME=/usr/local
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$PJPROJECT_HOME/lib
export PKG_CONFIG_PATH=/usr/local/lib/pkgconfig:$PKG_CONFIG_PATH

alias del="rm -rf"
alias vi="vim"
alias jupyter="jupyter lab --port=8888 --no-browser --NotebookApp.token=''"

gocustomer() {
  export GOROOT=~/.go_source_code
  export PATH=$GOROOT/bin:$PATH
}
gooriginal() {
  export GOROOT=~/.go1.24.2
  export PATH=$GOROOT/bin:$PATH
}

start_proxy() {
    sudo sing-box run -c ~/vpn_config.json >/dev/null 2>&1
}

set_proxy() {
    local ip_address
    ip_address=$(ip route | grep default | awk '{print $3}')

    # 设置 http_proxy 和 http_proxys 环境变量
    export http_proxy="socks5://$ip_address:10808"
    export https_proxy="socks5://$ip_address:10808"

    # 配置 Git 使用代理
    git config --global core.sshCommand "ssh -o ProxyCommand='nc -X 5 -x $ip_address:10808 %h %p'"
}

unset_proxy() {
    # 取消环境变量 http_proxy 和 http_proxys 设置
    unset http_proxy
    unset https_proxy

    # 移除 Git 中的代理配置
    git config --global --unset core.sshCommand
}

# 定义 Git 信息显示函数
git_prompt_info() {
  local branch git_status
  branch=$(git symbolic-ref --short HEAD 2>/dev/null)  # 获取当前 Git 分支的名称
  if [[ -n $branch ]]; then  # 如果是一个 Git 仓库
    git_status=$(git status --porcelain 2>/dev/null)  # 获取 Git 仓库的状态信息（检查是否有未提交的更改）
    if [[ -n $git_status ]]; then
      echo "%F{red}($branch)*%f"  # 如果有未提交的更改，显示 * 标记
    else
      echo "%F{green}($branch)%f"  # 如果没有未提交的更改，正常显示分支名
    fi
  fi
}

# 定义上一条命令的执行状态
exit_status_prompt() {
  if [[ -n "$exit_status" ]]; then  # 检查 exit_status 是否已经设置
    if [[ $exit_status -eq 0 ]]; then
      echo "%F{green}✔%f"  # 命令成功执行时显示绿色勾
    else
      echo "%F{red}✘%f"  # 命令失败时显示红色叉
    fi
  fi
}

# 使用 precmd hook 更新退出状态
precmd() {
  exit_status=$?  # 将上一条命令的退出状态保存到变量 exit_status 中
}

# 设置命令提示符
PROMPT='%F{cyan}%n%f %F{yellow}%~%f $(git_prompt_info) $(exit_status_prompt) '  # 左侧提示符（去除主机名）
RPROMPT='%F{blue}[%D{%Y-%m-%d %H:%M}]%f'  # 右侧显示当前日期和时间
