# ssh-agent起動
# ssh-agent.outにはssh-agentの出力結果をリダイレクトして保存しておく
# eval `cat ~/ssh-agent.out`
# ssh-add

if [ -x "`which anyenv 2>/dev/null`" ]; then
    eval "$(anyenv init -)"
fi

if [ -x "`which nodenv 2>/dev/null`" ]; then
    eval "$(nodenv init -)"
fi
