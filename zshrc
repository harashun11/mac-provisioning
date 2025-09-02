# Fig pre block. Keep at the top of this file.
[[ -f "$HOME/.fig/shell/zshrc.pre.zsh" ]] && builtin source "$HOME/.fig/shell/zshrc.pre.zsh"
export ZPLUG_HOME=/usr/local/opt/zplug
source $ZPLUG_HOME/init.zsh

zstyle ':completion:*:default' menu select=1
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z} r:|[._-]=*'
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' use-cache yes


# Plugins {{{

# Make sure to use double quotes
zplug "zsh-users/zsh-history-substring-search"

# Use the package as a command
# And accept glob patterns (e.g., brace, wildcard, ...)
zplug "Jxck/dotfiles", as:command, use:"bin/{histuniq,color}"

# Can manage everything e.g., other person's zshrc
zplug "tcnksm/docker-alias", use:zshrc

# Disable updates using the "frozen" tag
zplug "k4rthik/git-cal", as:command, frozen:1

# Grab binaries from GitHub Releases
# and rename with the "rename-to:" tag
zplug "junegunn/fzf-bin", \
    from:gh-r, \
    as:command, \
    rename-to:fzf, \
    use:"*darwin*amd64*"

# Supports oh-my-zsh plugins and the like
zplug "plugins/git",   from:oh-my-zsh

# Also prezto
# zplug "modules/prompt", from:prezto

# Load if "if" tag returns true
zplug "lib/clipboard", from:oh-my-zsh, if:"[[ $OSTYPE == *darwin* ]]"

# Run a command after a plugin is installed/updated
# Provided, it requires to set the variable like the following:
# ZPLUG_SUDO_PASSWORD="********"
zplug "jhawthorn/fzy", \
    as:command, \
    rename-to:fzy, \
    ook-build:"make && sudo make install"

# Supports checking out a specific branch/tag/commit
zplug "b4b4r07/enhancd", at:v1
zplug "mollifier/anyframe", at:4c23cb60

# Can manage gist file just like other packages
zplug "b4b4r07/79ee61f7c140c63d2786", \
    from:gist, \
    as:command, \
    use:get_last_pane_path.sh

# Support bitbucket
zplug "b4b4r07/hello_bitbucket", \
    from:bitbucket, \
    as:command, \
    use:"*.sh"

# Rename a command with the string captured with `use` tag
zplug "b4b4r07/httpstat", \
    as:command, \
    use:'(*).sh', \
    rename-to:'$1'

# Group dependencies
# Load "emoji-cli" if "jq" is installed in this example
zplug "stedolan/jq", \
    from:gh-r, \
    as:command, \
    rename-to:jq
zplug "b4b4r07/emoji-cli", \
    on:"stedolan/jq"
# Note: To specify the order in which packages should be loaded, use the defer
#       tag described in the next section

# Set the priority when loading
# e.g., zsh-syntax-highlighting must be loaded
# after executing compinit command and sourcing other plugins
# (If the defer tag is given 2 or above, run after compinit command)
zplug "zsh-users/zsh-syntax-highlighting", defer:2

# Can manage local plugins
# zplug "~/.zsh", from:local

# Load theme file
# zplug 'dracula/zsh', as:theme
zplug 'yous/lime'

# Install plugins if there are plugins that have not been installed
if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi

# Then, source plugins and add commands to $PATH
zplug load --verbose

# }}}


# ////////////
# ALIAS
# ////////////

# shortcut
alias dc='docker-compose'
alias tf='terraform'
alias g='git'
alias gs='g status'
alias tigs="tig status"
alias vi='vim'
alias sed='gsed'
alias findervisible='defaults write com.apple.finder AppleShowAllFiles TRUE; killall Finder;'
alias finderunvisible='defaults write com.apple.finder AppleShowAllFiles FALSE; killall Finder;'
alias ch='curl -D - -s -o /dev/null'

# default options
alias rm='rm -i'
alias ls='ls -GpF' # Mac OSX specific
alias ll='ls -alGpF' # Mac OSX specific
alias sl='ls' # mistake
#alias hc='hub compare'
#alias -s go='go run'
#alias hs='hugo server'
# gitの現在のブランチのhash
alias gnh='git rev-parse --short=7 $(git rev-parse --abbrev-ref HEAD) | pbcopy'
alias gg='git grep'
alias venv='python3 -m venv'

# ////////////
# EXPORT
# ////////////

export LANG=ja_JP.UTF-8
export EDITOR="vim"
export GOPATH=$HOME/Workspace/go
export PATH="/usr/loca/bin:$PATH:$GOPATH/bin"

export LSCOLORS=cxBxhxDxfxhxhxhxhxcxcx
export CLICOLOR=1

## support colors in less
#export LESS_TERMCAP_mb=$'\E[01;31m'
#export LESS_TERMCAP_md=$'\E[01;31m'
#export LESS_TERMCAP_me=$'\E[0m'
#export LESS_TERMCAP_se=$'\E[0m'
#export LESS_TERMCAP_so=$'\E[01;44;33m'
#export LESS_TERMCAP_ue=$'\E[0m'
#export LESS_TERMCAP_us=$'\E[01;32m'

# ////////////
# HISTORY
# ////////////

if [ -z "$HISTFILE" ]; then
    HISTFILE=$HOME/.zsh_history
fi

HISTSIZE=1000000
SAVEHIST=1000000

setopt append_history
setopt extended_history
setopt hist_expire_dups_first
setopt hist_ignore_all_dups 
setopt hist_ignore_dups 
setopt hist_ignore_space
setopt hist_verify
setopt inc_append_history
setopt share_history 
setopt nonomatch
# {{{ Setopt
setopt correct
setopt auto_name_dirs
setopt auto_remove_slash
setopt pushd_ignore_dups
setopt rm_star_silent
setopt sun_keyboard_hack
setopt extended_glob
setopt hist_ignore_all_dups
setopt no_beep
setopt sh_word_split
setopt auto_param_keys
setopt auto_pushd
setopt no_case_glob
setopt complete_in_word
setopt auto_list               # 補完候補を一覧で表示する(d)
setopt auto_menu               # 補完キー連打で補完候補を順に表示する(d)
setopt list_packed             # 補完候補をできるだけ詰めて表示する
setopt list_types              # 補完候補にファイルの種類も表示する
setopt inc_append_history

setopt prompt_subst

# コマンドラインの引数で --prefix=/usr などの = 以降でも補完できる
setopt magic_equal_subst
setopt auto_param_slash

# show japanese character
setopt print_eight_bit

# 範囲指定できるようにする
# 例 : mkdir {1-3} で フォルダ1, 2, 3を作れる
setopt brace_ccl

# C-s, C-qを無効にする。
setopt no_flow_control

# 先頭がスペースならヒストリーに追加しない。
setopt hist_ignore_space

# hide rprompt after execute the command.
setopt transient_rprompt

# treat comment after sharp.
setopt interactive_comments

# do not share history within shells
setopt share_history

# ディレクトリ名だけで移動できる。
setopt auto_cd
#cdpath=(.. ~ ~/src)

# 重複を記録しない
setopt hist_ignore_dups

# 開始と終了を記録
setopt extended_history

# }}}


# ////////////
# prompt
# ////////////

# no beep
setopt nolistbeep

# old style
#autoload -u colors && colors
#autoload -u promptinit; promptinit
# install via 'npm install --global pure-prompt'
#pure_prompt_symbol=λ
#prompt pure

# fatih style
autoload -U colors && colors
setopt promptsubst

local ret_status="%(?:%{$fg_bold[green]%}λ :%{$fg_bold[green]%}$)"
PROMPT='${ret_status} %{$fg[cyan]%}%c%{$reset_color%} $(git_prompt_info)'

ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg_bold[blue]%}git:(%{$fg[red]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%} "
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[blue]%}) %{$fg[yellow]%}✗"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg[blue]%})"

# custom functions
function chpwd() { ls }

# Outputs current branch info in prompt format
function git_prompt_info() {
  local ref
  if [[ "$(command git config --get customzsh.hide-status 2>/dev/null)" != "1" ]]; then
    ref=$(command git symbolic-ref HEAD 2> /dev/null) || \
    ref=$(command git rev-parse --short HEAD 2> /dev/null) || return 0
    echo "$ZSH_THEME_GIT_PROMPT_PREFIX${ref#refs/heads/}$(parse_git_dirty)$ZSH_THEME_GIT_PROMPT_SUFFIX"
  fi
}

# Checks if working tree is dirty
function parse_git_dirty() {
  local STATUS=''
  local FLAGS
  FLAGS=('--porcelain')

  if [[ "$(command git config --get customzsh.hide-dirty)" != "1" ]]; then
    FLAGS+='--ignore-submodules=dirty'
    STATUS=$(command git status ${FLAGS} 2> /dev/null | tail -n1)
  fi

  if [[ -n $STATUS ]]; then
    echo "$ZSH_THEME_GIT_PROMPT_DIRTY"
  else
    echo "$ZSH_THEME_GIT_PROMPT_CLEAN"
  fi
}

# ////////////
# AUTOCOMPLETION
# ////////////

fpath=($(brew --prefix)/share/zsh/site-functions $fpath)

# enable completion
autoload -U compinit
compinit -u

# ////////////
# KEY BINDINGS
# ////////////

# vi like keybind
bindkey -v

# [Ctrl-r] - Search backward incrementally for a specified string. The string
# may begin with ^ to anchor the search to the beginning of the line.
bindkey '^r' history-incremental-search-backward      
bindkey -e
bindkey "^[[Z" reverse-menu-complete  # Shift-Tabで補完候補を逆順する("\e[Z"でも動作する)
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}' # 補完時に大文字小文字を区別しない
bindkey \^u backward-kill-line


# ////////////
# THIRD PARTY
# ////////////

# brew install jump via https://github.com/gsamokovarov/jump
eval "$(jump shell)"

# brew install direnv via https://github.com/direnv/direnv
eval "$(direnv hook zsh)"

# brew install goenv via 
export PATH="$HOME/.goenv/bin:$PATH"
eval "$(goenv init -)"

# brew install rbenv via
export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"
export PATH="/usr/local/opt/mysql@5.6/bin:$PATH"
export PATH=$PATH:/Users/harashun11/.nodebrew/current/bin
export PATH="$HOME/.anyenv/bin:$PATH"

eval "$(anyenv init -)"
export PATH="/usr/local/opt/mysql@5.7/bin:$PATH"

eval "$(pyenv init -)"

export PATH="$PATH:$HOME/.pub-cache/bin"

# export ANDROID_HOME=${HOME}/Library/Android/sdk
# export ANDROID_SDK_ROOT=${HOME}/Library/Android/sdk
# if [ -d "${ANDROID_HOME}" ]; then
#   export PATH="${ANDROID_HOME}/bin:$PATH"
# fi
# 
# # Platform-Toolsのパスを通す
# export ANDROID_TOOL_PATH=${ANDROID_HOME}/platform-tools
# if [ -d "${ANDROID_TOOL_PATH}" ]; then
#   export PATH="${ANDROID_TOOL_PATH}:$PATH"
# fi

export ANDROID_HOME=$HOME/Library/Android/sdk
export PATH=$PATH:$ANDROID_HOME/emulator
export PATH=$PATH:$ANDROID_HOME/platform-tools
# export JAVA_HOME=/Library/Java/JavaVirtualMachines/temurin-17.jdk/Contents/Home
export JAVA_HOME=/Library/Java/JavaVirtualMachines/amazon-corretto-11.jdk/Contents/Home

# Fig post block. Keep at the bottom of this file.
[[ -f "$HOME/.fig/shell/zshrc.post.zsh" ]] && builtin source "$HOME/.fig/shell/zshrc.post.zsh"

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"

eval "$(mise activate zsh)"

## [Completion]
## Completion scripts setup. Remove the following line to uninstall
[[ -f /Users/pc234/.dart-cli-completion/zsh-config.zsh ]] && . /Users/pc234/.dart-cli-completion/zsh-config.zsh || true
## [/Completion]


alias flutter="fvm flutter"
export PATH="$HOME/.jenv/bin:$PATH"
eval "$(jenv init -)"

# pnpm
export PNPM_HOME="/Users/pc234/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end
export PATH=~/.npm-global/bin:$PATH

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/pc234/Workspace/orange0/emaqi/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/pc234/Workspace/orange0/emaqi/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/pc234/Workspace/orange0/emaqi/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/pc234/Workspace/orange0/emaqi/google-cloud-sdk/completion.zsh.inc'; fi
