# (d) is default on

# ------------------------------
# General Settings
# ------------------------------
export EDITOR=vim        # エディタをvimに設定
export LANG=ja_JP.UTF-8  # 文字コードをUTF-8に設定
export KCODE=u           # KCODEにUTF-8を設定
export AUTOFEATURE=true  # autotestでfeatureを動かす
export PAGER=less        # less
export LESS='-R'         # colorful less

bindkey -v               # キーバインドをviモードに設定

setopt AUTO_CD           # ディレクトリ名入力で cd する
setopt auto_pushd        # cd時にディレクトリスタックにpushdする
#setopt correct          # コマンドのスペルを訂正する
setopt prompt_subst      # プロンプト定義内で変数置換やコマンド置換を扱う
setopt notify            # バックグラウンドジョブの状態変化を即時報告する
#setopt equals            # =commandを`which command`と同じ処理にする

### Complement ###
autoload -U compinit; compinit # 補完機能を有効にする
setopt auto_list               # 補完候補を一覧で表示する(d)
setopt auto_menu               # 補完キー連打で補完候補を順に表示する(d)
setopt list_packed             # 補完候補をできるだけ詰めて表示する
setopt list_types              # 補完候補にファイルの種類も表示する
bindkey "^[[Z" reverse-menu-complete  # Shift-Tabで補完候補を逆順する("\e[Z"でも動作する)
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}' # 補完時に大文字小文字を区別しない

### History ###
HISTFILE=~/.zsh_history   # ヒストリを保存するファイル
HISTSIZE=100000            # メモリに保存されるヒストリの件数
SAVEHIST=100000            # 保存されるヒストリの件数
setopt bang_hist          # !を使ったヒストリ展開を行う(d)
setopt extended_history   # ヒストリに実行時間も保存する
setopt hist_ignore_dups   # 直前と同じコマンドはヒストリに追加しない
setopt share_history      # 他のシェルのヒストリをリアルタイムで共有する
setopt hist_reduce_blanks # 余分なスペースを削除してヒストリに保存する

# マッチしたコマンドのヒストリを表示できるようにする
autoload history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^P" history-beginning-search-backward-end
bindkey "^N" history-beginning-search-forward-end
# インクリメンタルサーチ
bindkey "^R" history-incremental-search-backward

# すべてのヒストリを表示する
function history-all { history -E 1 }

# ------------------------------
# Look And Feel Settings
# ------------------------------
### Ls Color ###
# 色の設定
export LSCOLORS=Exfxcxdxbxegedabagacad
# 補完時の色の設定
export LS_COLORS='di=01;34:ln=01;35:so=01;32:ex=01;31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'
# ZLS_COLORSとは？
export ZLS_COLORS=$LS_COLORS
# lsコマンド時、自動で色がつく(ls -Gのようなもの？)
export CLICOLOR=true
# 補完候補に色を付ける
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}

### Prompt ###
# http://yoshiko.hatenablog.jp/entry/2014/04/02/zsh%E3%81%AE%E3%83%97%E3%83%AD%E3%83%B3%E3%83%97%E3%83%88%E3%81%ABgit%E3%81%AE%E3%82%B9%E3%83%86%E3%83%BC%E3%82%BF%E3%82%B9%E3%82%92%E3%82%B7%E3%83%B3%E3%83%97%E3%83%AB%E5%8F%AF%E6%84%9B%E3%81%8F
# プロンプトに色を付ける
autoload -Uz vcs_info
zstyle ':vcs_info:*' enable git svn
zstyle ':vcs_info:*' max-exports 6 # formatに入る変数の最大数
zstyle ':vcs_info:git:*' check-for-changes true
zstyle ':vcs_info:git:*' formats '%b@%r' '%c' '%u'
zstyle ':vcs_info:git:*' actionformats '%b@%r|%a' '%c' '%u'
setopt prompt_subst
function vcs_echo {
    local st branch color
    STY= LANG=en_US.UTF-8 vcs_info
    st=`git status 2> /dev/null`
    if [[ -z "$st" ]]; then return; fi
    branch="$vcs_info_msg_0_"
    if   [[ -n "$vcs_info_msg_1_" ]]; then color=${fg[green]} #staged
    elif [[ -n "$vcs_info_msg_2_" ]]; then color=${fg[red]} #unstaged
    elif [[ -n `echo "$st" | grep "^Untracked"` ]]; then color=${fg[blue]} # untracked
    else color=${fg[cyan]}
    fi
    echo "%{$color%}(%{$branch%})%{$reset_color%}" | sed -e s/@/"%F{yellow}@%f%{$color%}"/
}
PROMPT='
[%F{yellow}%~%f@%F{green}${HOST%%.*}%f] `vcs_echo`
%(?.$.%F{red}$%f) '

# SSHログイン時のプロンプト
# [ -n "${REMOTEHOST}${SSH_CONNECTION}" ] &&
#   PROMPT="%{${fg[white]}%}${HOST%%.*} ${PROMPT}"
# ;

#Title
precmd() {
    [[ -t 1 ]] || return
    case $TERM in
        *xterm*|rxvt|(dt|k|E)term)
        print -Pn "\e]2;[%~]\a"
	;;
        # screen)
        #      #print -Pn "\e]0;[%n@%m %~] [%l]\a"
        #      print -Pn "\e]0;[%n@%m %~]\a"
        #      ;;
    esac
}


# ------------------------------
# Other Settings
# ------------------------------

### Aliases ###
alias history='history -E' #時刻を表示させる

alias ls='ls --color -F'
alias ll='ls -l'
alias la='ls -A'
alias lla='ls -lA'
alias tree='tree -N'

alias df='df -h'
alias du='du -h'

alias rm='rm -i'
alias mv='mv -i'
alias cp='cp -i'

alias -g G='| grep'

alias -g r='rails'
alias -g sr='spring rails'
alias -g RET='RAILS_ENV=test'

alias -g mm='middleman'

# tree
alias tree='tree --charset=C -NC'

# PATHを1行1パスで表示
alias showpath="echo $PATH | sed 's/:/\n/g'"

# Bundle関連
alias be='bundle exec'
alias brspec='bundle exec rspec --color'
alias -g FD='--format documentation --color'

# tmux
alias tmux='tmux -2'
alias tcopy='tmux save-buffer - | pbcopy'
alias tkill='tmux kill-server'

alias rtags='ctags --langmap=RUBY:.rb --exclude="*.js"  --exclude=".git*" -R .'

# cdコマンド実行後、lsを実行する
function cd() {
  builtin cd $@ && ls --color -F;
}

# vi means vim without setttings and plugin
alias vi="vim -u NONE --noplugin"
# vim received xargs
alias xargsvim='xargs sh -c '\''vim $* < /dev/tty'\'''

# cdコマンド実行後、lsを実行する
function mkcd() { mkdir -p -- "$1" && cd -- "$1" }
# 行番号付き
function headln(){ head $@ | awk '{print sprintf("%02d", NR) " " $0;}' }
function catln(){ cat $@ | awk '{print sprintf("%03d", NR) " " $0;}' }

# 辞書を引く(英和)
function ejdict() {
  grep "$1" /usr/share/dict/dict -E -A 1 -wi --color=always | less -FX
}
# 辞書を引く(和英)
function jedict() {
  grep "$1" /usr/share/dict/dict -E -B 1 -wi --color=always | less -FX
}
# 辞書のデフォルトは英和
alias dict='ejdict'

# ssh-agent更新
function ssh-update() {
  ssh-agent > ~/ssh-agent.out
  eval `cat ~/ssh-agent.out`
  ssh-add
}

# ------------------------------
# for rbenv
# ------------------------------
if [[ -s ~/.rbenv/bin ]];
  then export PATH=$HOME/.rbenv/bin:$PATH && eval "$(rbenv init -)"
fi

# ------------------------------
# nvm環境
# ------------------------------
if [[ -s ~/.nvm/nvm.sh ]];
  then source ~/.nvm/nvm.sh
fi

# ------------------------------
# kiex環境
# ------------------------------
if [[ -s ~/.kiex/scripts/kiex ]];
  then source ~/.kiex/scripts/kiex
fi

# ------------------------------
# docker-compose
# (コンテナ名appは決め打ち)
# ------------------------------
alias dcompose='docker-compose'
alias dcrun='docker-compose run'
alias dcbash='docker-compose run app bash'

# with Elixir
## for default env
alias dcmix='docker-compose run app mix'
alias dcmixe='docker-compose run app mix run -e'
alias dcmixi='docker-compose run app iex -S mix'
alias dcmxrt='docker-compose run app mix phoenix.routes'
alias dcmxdbinit='docker-compose run app mix ecto.setup'
alias dcmxdbreset='docker-compose run app mix ecto.reset'
## for test env
alias dcmxtest='docker-compose run -e MIX_ENV=test app mix test'
alias dcmxcredo='docker-compose run -e MIX_ENV=test app mix credo; grep_target_tag_for_exunit'
alias dcmxcheck='docker-compose run -e MIX_ENV=test app mix do test, credo; grep_target_tag_for_exunit'
alias dcmxt='docker-compose run -e MIX_ENV=test app mix'
alias dcmxte='docker-compose run -e MIX_ENV=test app mix run -e'
alias dcmxti='docker-compose run -e MIX_ENV=test app iex -S mix'
alias dcmxtdbinit='docker-compose run -e MIX_ENV=test app mix ecto.setup'
alias dcmxtdbreset='docker-compose run -e MIX_ENV=test app mix ecto.reset'
# 一時的にテスト対象を絞るために使っている"@tag :target"を検出
function grep_target_tag_for_exunit() {
  echo 'Checking "@tag :target"...\n'
  grep -n -E "@tag\s+:target" test/**/*.exs
  if [ $? -eq 0 ]; then
    echo -e '\e[31m\nWARNING: Please erase temporal tags. \e[m'
  else
    echo '\e[32mOK: There are no temporal tags.\e[m'
  fi
}
# ssh and open bash on pod that identified by prefix passed as argument
function kubectl_ssh_bash_prefixed_pod() {
  pod=$(kubectl get pod | grep $1 -m 1 | sed -r "s/(${1}\S+)\s+.*/\1/")
  kubectl exec -it $pod /bin/bash
}

# ------------------------------
# local環境
# ------------------------------
if [ -e "${HOME}/.zshrc_local" ]; then
  source "${HOME}/.zshrc_local"
fi
