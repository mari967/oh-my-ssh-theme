autoload -U add-zsh-hook
autoload -Uz vcs_info

local c0=$(printf "\033[0m")
local c1=$(printf "\033[38;5;215m")
local c2=$(printf "\033[38;5;209m")
local c3=$(printf "\033[38;5;203m")
local c4=$(printf "\033[33;4m")
local c5=$(printf "\033[38;5;137m")
local c6=$(printf "\033[38;5;240m")
local c7=$(printf "\033[38;5;149m") #Light green
local c8=$(printf "\033[38;5;126m")
local c9=$(printf "\033[38;5;162m")

if [ "$TERM" = "linux" ]; then
    c1=$(printf "\033[34;1m")
    c2=$(printf "\033[35m")
    c3=$(printf "\033[31m")
    c4=$(printf "\033[31;1m")
    c5=$(printf "\033[32m")
    c6=$(printf "\033[32;1m")
    c7=$(printf "\033[33m")
    c8=$(printf "\033[33;1m")
    c9=$(printf "\033[34m")
fi

zstyle ':vcs_info:*' actionformats \
    '%{$c8%}(%f%s)%{$c7%}-%F{5}[%F{2}%b%F{3}|%F{1}%a%F{5}]%f '
zstyle ':vcs_info:*' formats \
    "%{$c8%}%s%{$c7%}:%{$c7%}(%{$c9%}%b%{$c7%})%f "
zstyle ':vcs_info:*' enable git

add-zsh-hook precmd prompt_jnrowe_precmd

prompt_jnrowe_precmd () {
    vcs_info
    #dir_status="%{$c1%}%n%{$c4%}@%{$c2%}%m%{$c0%}:%{$c4%}%/%{$c0%}"
    dir_status="%{$c4%}%/%{$c0%}"
    branch_status="$(parse_git_dirty)"
    start_symbol="%{$c2%}>%{$reset_color%}"
    if [ "${vcs_info_msg_0_}" = "" ]; then
        PROMPT='${dir_status} ${ret_status}
${start_symbol} '
    elif [[ $(git diff --cached --name-status 2>/dev/null ) != "" ]]; then
        PROMPT='${dir_status} ${vcs_info_msg_0_}${branch_status}
${start_symbol} '
    elif [[ $(git diff --name-status 2>/dev/null ) != "" ]]; then
        PROMPT='${dir_status} ${vcs_info_msg_0_}${branch_status}%{$c9%}
·>%{$c0%} '
    else
        PROMPT='${dir_status} ${vcs_info_msg_0_}${branch_status}
${start_symbol} '
    fi
}


ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[red]%}X"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$c7%}ok"