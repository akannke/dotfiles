alias bitm='bitcoin-cli'
alias bitt='bitcoin-cli -testnet'

# neovimを使う
alias view='nvim -R'
alias vim='nvim'

# 間違ってcrontab -rをしないために
alias crontab='crontab -i'
alias grep='grep -E'
# alias solc='docker run --rm -v $(pwd):/solidity ethereum/solc:0.4.24'

# コピペ
alias pbcopy='xsel --clipboard --input'

alias open='xdg-open'

# nvimターミナル内でネストしないようにする
if [[ -n $NVIM_LISTEN_ADDRESS ]] && type nvr &> /dev/null; then
    alias nvim='nvr'
fi

# atcoder用のエイリアス
if type cargo-compete >/dev/null 2>&1; then
    alias co='cargo compete'
fi

# PATHを改行して表示
alias mypath='echo $PATH | tr ":" "\n"'
alias open='xdg-open'
