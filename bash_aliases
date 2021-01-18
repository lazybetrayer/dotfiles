# vim: ft=sh et

alias ll='ls -lF'
alias la='ls -A'
alias l='ls -CF'
alias vi=vim
alias diff='diff -u'
alias mv='mv -i'
alias cp='cp -i'
alias rm='rm -i'
alias ..='cd ..'
alias tree='tree -N'
alias sc=screen
alias ta='tmux -2 a'
alias td='tmux -2 a -d'
alias tml='tmux ls'
alias tmux='tmux -2'
alias tmk='tmux kill-session'
alias less='less -R'
alias sudo='sudo ' # to pass aliases through sudo
alias hd='hexdump -C'
alias curl-trace='curl -w "@$HOME/.curl-format" -o /dev/null -s'
alias setproxy='. ~/scripts/proxy'
alias unsetproxy='. ~/scripts/unset-proxy'

alias g='git'
#_completion_loader git 2>/dev/null || true
complete -o bashdefault -o default -o nospace -F __git_wrap__git_main g
alias git-root='cd $(git rev-parse --show-toplevel || echo .)'

alias d='docker'
#_completion_loader docker 2>/dev/null || true
complete -F _docker d

alias k='kubectl'
#_completion_loader kubectl 2>/dev/null || true
complete -F __start_kubectl k

# URL-encode strings
alias urlencode='python3 -c "import sys, urllib.parse as parse; print(parse.quote_plus(sys.argv[1] if len(sys.argv) > 1 else input()));"'
alias urldecode='python3 -c "import sys, urllib.parse as parse; print(parse.unquote_plus(sys.argv[1] if len(sys.argv) > 1 else input()));"'
#alias htmldecode='python -c "import sys; from HTMLParser import HTMLParser; print(HTMLParser().unescape(sys.argv[1] if len(sys.argv) > 1 else raw_input()));"'
alias htmlencode='python3 -c "import sys, html; print(html.escape(sys.argv[1] if len(sys.argv) > 1 else input()));"'
alias htmldecode='python3 -c "import sys, html; print(html.unescape(sys.argv[1] if len(sys.argv) > 1 else input()));"'
alias yaml2json='python3 -c "import sys, yaml, json; json.dump(yaml.safe_load(sys.stdin), sys.stdout, ensure_ascii=False, indent=2)"'
alias json2yaml='python3 -c "import sys, yaml, json; yaml.safe_dump(json.load(sys.stdin), sys.stdout, default_flow_style=False, allow_unicode=True)"'
alias unicode_escape='python3 -c "import sys; print((sys.argv[1] if len(sys.argv) > 1 else input()).encode(\"unicode-escape\").decode())"'
alias unicode='python3 -c "import sys; print((sys.argv[1] if len(sys.argv) > 1 else input()).encode().decode(\"unicode-escape\"))"'

#alias myip="dig +short myip.opendns.com @resolver1.opendns.com"
alias myip="nc ns1.dnspod.net 6666; echo"

ipip() {
    curl "http://freeapi.ipip.net/$1"
    echo
}

#if dir,cd into it. if file ,cd into where the file is
goto(){ [ -d "$1" ] && cd "$1" || cd "$(dirname "$1")"; }

svndiff() {
    svn diff "${@}" | view -
}

print_color_table() {
    for fgbg in 38 48 ; do #Foreground/Background
        for color in {0..256} ; do #Colors
            #Display the color
            printf "\e[0;${fgbg};5;${color}m%4d\e[0m" ${color}
            printf "\e[1;${fgbg};5;${color}m%4d\e[0m" ${color}
            #Display 10 colors per lines
            if [ $(((color + 1) % 10)) == 0 ] ; then
                echo #New line
            fi
        done
        echo #New line
    done
}

httpless() {
    # pip install httpie
    http --pretty=all --print=hb "$@" | less -R
}

gocd() { cd "$(go list -f '{{.Dir}}' "$1")" || exit; }

# Create a data URL from a file
dataurl() {
    local typ
    typ=$(file -b --mime-type "$1");
    if [[ $typ == text/* ]]; then
        typ="${typ};charset=utf-8";
    fi
    echo "data:${typ};base64,$(openssl base64 -in "$1" | tr -d '\n')";
}

