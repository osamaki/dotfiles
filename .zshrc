# 範囲指定できるように 例) mkdir {1-3} で フォルダ1,2,3を作れる
setopt brace_ccl

# 直前と同じコマンドの場合はヒストリに追加しない
setopt hist_ignore_dups
# 同じコマンドをヒストリに残さない
# setopt hist_ignore_all_dups
# ヒストリに保存するときに余分なスペースを削除する
setopt hist_reduce_blanks



export PS1="%~
: "
export PATH="/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin"
export PATH="$PATH:/Library/Frameworks/Python.framework/Versions/3.8/bin/"
# "/Users/admin/Desktop/ccg/learningbyreading/ext/candc/bin
export PATH="$PATH:$HOME/Repositories/MyScripts"

# brew
eval "$(/opt/homebrew/bin/brew shellenv)"

## Fuzzy match
### https://gihyo.jp/dev/serial/01/zsh-book/0005 を参考
### 補完候補がなければより曖昧に候補を探す
### m:{a-z}={A-Z}: 小文字を大文字に変えたものでも補完する
### r:|[._-]=*: 「.」「_」「-」の前にワイルドカード「*」があるものとして補完する
### l:|=*: 入力文字の前にワイルドカード「*」があるものとして補完する
### r:|?=**: 各入力文字の前後に「*」があるものとして補完する
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}' '+m:{A-Z}={a-z}' '+r:|[-_.]=**' '+l:|=*' '+r:|?=**'

# pythonのimportパス
export PYTHONPATH="$PYTHONPATH:$HOME/Repositories"

# for pyenv
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

# for node.js
export PATH="$PATH:$HOME/.nodebrew/current/bin"
export SSL_CERT_FILE="/Users/osamaki/Downloads/cacert-2022-03-29.pem"


# git
alias ga="git add"
alias gs="git status"
alias gcmsg="git commit -m"

# 使ってない
alias pdf="rbenv exec pdf-extract"

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

alias rm="rm -i"

source ~/Repositories/MyScripts/scripts.sh


#========================
# zsh-syntax-highlighting
# installation:
# mkdir ~/.zsh
# git clone git://github.com/zsh-users/zsh-syntax-highlighting.git ~/.zsh/zsh-syntax-highlighting
#========================
if [ -f ~/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]; then
  source ~/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
fi


# タブ補完
autoload -U compinit
compinit
_comp_options+=(globdots)  # include hidden files
zstyle ':completion:*:default' menu select=1


# edit line in vim with ctrl-e
autoload edit-command-line; zle -N edit-command-line
bindkey '^v' edit-command-line


# for prolog
# export PATH=$PATH:"/Applications/SWI-Prolog.app/Contents/MacOS"
alias prolog="swipl"

# peco
# function peco-select-history() {
  # BUFFER=$(\history -n 1 | tac | peco)
  # CURSOR=$#BUFFER
  # zle clear-screen
# }
# zle -N peco-select-history
# bindkey '^r' peco-select-history

# fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
# .git以外の.ファイル，.ディレクトリを検索
export FZF_DEFAULT_COMMAND='find . -type f -not -path "*/.git/*" -o -type l 2> /dev/null | sed s/^..//'
# 意味ない
# bindkey '^F' fzf-file-widget
