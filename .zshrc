export PS1="%~
: "
export PATH="/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/Library/Frameworks/Python.framework/Versions/3.8/bin/:/Users/admin/Desktop/ccg/learningbyreading/ext/candc/bin:/Users/admin/Library/Android/sdk/platform-tools"

## Fuzzy match
### https://gihyo.jp/dev/serial/01/zsh-book/0005 を参考
### 補完候補がなければより曖昧に候補を探す
### m:{a-z}={A-Z}: 小文字を大文字に変えたものでも補完する
### r:|[._-]=*: 「.」「_」「-」の前にワイルドカード「*」があるものとして補完する
### l:|=*: 入力文字の前にワイルドカード「*」があるものとして補完する
### r:|?=**: 各入力文字の前後に「*」があるものとして補完する
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}' '+m:{A-Z}={a-z}' '+r:|[-_.]=**' '+l:|=*' '+r:|?=**'

export PYTHONPATH="$PYTHONPATH:$HOME/Repositories"

# for pyenv
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

# for node.js
export PATH=$HOME/.nodebrew/current/bin:$PATH
export SSL_CERT_FILE="/Users/admin/.local/share/virtualenvs/nlp-0joC6egm/lib/python3.8/site-packages/certifi/cacert.pem"

alias pdf="rbenv exec pdf-extract"

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

alias rm="rm -i"
