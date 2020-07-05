# ZSH theme based on avit and michelebologna

CARET="❯"
CARETCOLOR="magenta"
ME=""
DIRCOLOR="blue"
if [[ -n $SSH_CONNECTION ]]; then
  CARET="%#"
  CARETCOLOR="cyan"
  ME="%m "
  DIRCOLOR="white"
elif [[ $LOGNAME != $USER ]]; then
  CARET="%#"
  CARETCOLOR="yellow"
  ME="%n%m "
  DIRCOLOR="white"
fi

PROMPT='
%{$fg[white]%}(%D %*) <%?> ${_current_dir}$(git_prompt_info)$(git_prompt_status)$(git_remote_status)
${_return_status}$ME$CARET%{$reset_color%} '

RPROMPT=''

local _current_dir="%{$fg[$DIRCOLOR]%}%~%{$reset_color%} "
local _return_status="%(?.%{$fg[$CARETCOLOR]%}.%{$fg[red]%})"
local _hist_no="%{$fg[grey]%}%h%{$reset_color%}"

function _vi_status() {
  if {echo $fpath | grep -q "plugins/vi-mode"}; then
    echo "$(vi_mode_prompt_info)"
  fi
}

# Determine the time since last commit. If branch is clean,
# use a neutral color, otherwise colors will vary according to time.
function _git_time_since_commit() {
# Only proceed if there is actually a commit.
  if last_commit=$(git log --pretty=format:'%at' -1 2> /dev/null); then
    now=$(date +%s)
    seconds_since_last_commit=$((now-last_commit))

    # Totals
    minutes=$((seconds_since_last_commit / 60))
    hours=$((seconds_since_last_commit/3600))

    # Sub-hours and sub-minutes
    days=$((seconds_since_last_commit / 86400))
    sub_hours=$((hours % 24))
    sub_minutes=$((minutes % 60))

    if [ $hours -ge 24 ]; then
      commit_age="${days}d"
    elif [ $minutes -gt 60 ]; then
      commit_age="${sub_hours}h${sub_minutes}m"
    else
      commit_age="${minutes}m"
    fi

    color=$ZSH_THEME_GIT_TIME_SINCE_COMMIT_NEUTRAL
    echo "$color$commit_age%{$reset_color%}"
  fi
}

ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg[green]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"

ZSH_THEME_GIT_PROMPT_DIRTY=""
ZSH_THEME_GIT_PROMPT_CLEAN=""
ZSH_THEME_GIT_PROMPT_UNTRACKED="%{$fg[blue]%}%%"
ZSH_THEME_GIT_PROMPT_DELETED="%{$fg[red]%}-"
ZSH_THEME_GIT_PROMPT_MODIFIED="%{$fg[red]%}*"
ZSH_THEME_GIT_PROMPT_ADDED="%{$fg[green]%}+"
ZSH_THEME_GIT_PROMPT_STASHED="%{$fg[blue]%}$"
ZSH_THEME_GIT_PROMPT_EQUAL_REMOTE="%{$fg[green]%}="
ZSH_THEME_GIT_PROMPT_AHEAD_REMOTE=">"
ZSH_THEME_GIT_PROMPT_BEHIND_REMOTE="<"
ZSH_THEME_GIT_PROMPT_DIVERGED_REMOTE="%{$fg[red]%}<>"

# Colors vary depending on time lapsed.
# ZSH_THEME_GIT_TIME_SINCE_COMMIT_SHORT="%{$fg[green]%}"
# ZSH_THEME_GIT_TIME_SHORT_COMMIT_MEDIUM="%{$fg[yellow]%}"
# ZSH_THEME_GIT_TIME_SINCE_COMMIT_LONG="%{$fg[red]%}"
# ZSH_THEME_GIT_TIME_SINCE_COMMIT_NEUTRAL="%{$fg[white]%}"

# LS colors, made with https://geoff.greer.fm/lscolors/
# export LSCOLORS="exfxcxdxbxegedabagacad"
# export LS_COLORS='di=34;40:ln=35;40:so=32;40:pi=33;40:ex=31;40:bd=34;46:cd=34;43:su=0;41:sg=0;46:tw=0;42:ow=0;43:'
# export GREP_COLOR='1;33'
