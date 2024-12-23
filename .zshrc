export XDG_DATA_HOME="$HOME/.local/share"


# 範囲指定できるように 例) mkdir {1-3} で フォルダ1,2,3を作れる
setopt brace_ccl

# 直前と同じコマンドの場合はヒストリに追加しない
setopt hist_ignore_dups
# 同じコマンドをヒストリに残さない
# setopt hist_ignore_all_dups
# ヒストリに保存するときに余分なスペースを削除する
setopt hist_reduce_blanks


# 色系
autoload -Uz colors && colors
# export PS1="%~
# : "
# PROMPT="[%F{green}%m%f-%F{yellow}(%~)%f]%T
PROMPT="(%F{yellow}%~%f) %T
$ "
LS_COLORS=':no=00:fi=00:di=36:ln=35:pi=33:so=32:bd=34;46:cd=34;43:ex=31:'
TERM='xterm-256color'

# git ブランチ名を色付きで表示させるメソッド
function rprompt-git-current-branch {
  local branch_name st branch_status

  if [ ! -e  ".git" ]; then
    # git 管理されていないディレクトリは何も返さない
    return
  fi
  branch_name=`git rev-parse --abbrev-ref HEAD 2> /dev/null`
  st=`git status 2> /dev/null`
  if [[ -n `echo "$st" | grep "^nothing to"` ]]; then
    # 全て commit されてクリーンな状態
    branch_status="%F{green}"
  elif [[ -n `echo "$st" | grep "^Untracked files"` ]]; then
    # git 管理されていないファイルがある状態
    branch_status="%F{red}?"
  elif [[ -n `echo "$st" | grep "^Changes not staged for commit"` ]]; then
    # git add されていないファイルがある状態
    branch_status="%F{red}+"
  elif [[ -n `echo "$st" | grep "^Changes to be committed"` ]]; then
    # git commit されていないファイルがある状態
    branch_status="%F{yellow}!"
  elif [[ -n `echo "$st" | grep "^rebase in progress"` ]]; then
    # コンフリクトが起こった状態
    echo "%F{red}!(no branch)"
    return
  else
    # 上記以外の状態の場合
    branch_status="%F{blue}"
  fi
  # ブランチ名を色付きで表示する
  echo "${branch_status}[$branch_name]"
}

# プロンプトが表示されるたびにプロンプト文字列を評価、置換する
setopt prompt_subst

# プロンプトの右側にメソッドの結果を表示させる
RPROMPT='`rprompt-git-current-branch`'

#========================
# zsh-syntax-highlighting
# installation:
# mkdir ~/.zsh
# git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.zsh/zsh-syntax-highlighting
#========================
if [ -f ~/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]; then
  source ~/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
fi


#========================
# zsh-autosuggestions
# installation:
# mkdir ~/.zsh
# git clone https://github.com/zsh-users/zsh-autosuggestions ~/.zsh/zsh-autosuggestions
#========================
if [ -f ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh ]; then
  source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
  bindkey '^j' autosuggest-accept
fi


export PATH="/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin"
export PATH="$PATH:/Library/Frameworks/Python.framework/Versions/3.8/bin/"
# "/Users/admin/Desktop/ccg/learningbyreading/ext/candc/bin
export PATH="$PATH:$HOME/Repositories/MyScripts"
export PATH="/Users/osamaki/Library/Python/3.8/bin:$PATH"

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

# for pipx
export PIPX_HOME="$XDG_DATA_HOME/pipx"

# for pyenv
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

# for node.js
export PATH="$PATH:$HOME/.nodebrew/current/bin"
# export SSL_CERT_FILE="/Users/osamaki/Downloads/cacert-2022-03-29.pem"

# for vim
# vimrcでg:python3_host_progに設定する
export PYTHON3_HOST_PROG="/usr/bin/python3"


# git
alias ga="git add"
alias gs="git status"
alias gcmsg="git commit -m"

# alias pdf="rbenv exec pdf-extract"

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

alias rm="rm -i"

source ~/Repositories/MyScripts/scripts.sh


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


case ${OSTYPE} in
  darwin*)
  # for mac
  alias ldd="otool -L"
    ;;
esac

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
export FZF_DEFAULT_COMMAND='find . -type f \( -not -path "*/.git/*" -not -path "*/.mypy_cache/*" -not -path "*/.vim/view/*" \) -o -type l 2> /dev/null | sed s/^..//'
# export FZF_DEFAULT_COMMAND="rg --files-with-matches --hidden '.' --glob '!.git'"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
# key-bindings.zsh の fzf-file-widget の bind を ctrl-E に変える


ZSH_FILES_DIR="${HOME}/.zsh"
for i in $ZSH_FILES_DIR/*\.zsh; do
  . $i
done
