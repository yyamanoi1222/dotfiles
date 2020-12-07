source ~/.bashrc
# source ~/.zplug/init.zsh
#
# zplug "mollifier/cd-gitroot"
# alias cdu='cd-gitroot'
# zplug load

autoload -Uz vcs_info
autoload -Uz colors # black red green yellow blue magenta cyan white
colors

# PROMPT変数内で変数参照
setopt prompt_subst

zstyle ':vcs_info:git:*' check-for-changes true #formats 設定項目で %c,%u が使用可
zstyle ':vcs_info:git:*' stagedstr "%F{green}!" #commit されていないファイルがある
zstyle ':vcs_info:git:*' unstagedstr "%F{magenta}+" #add されていないファイルがある
zstyle ':vcs_info:*' formats "%F{cyan}%c%u(%b)%f" #通常
zstyle ':vcs_info:*' actionformats '[%b|%a]' #rebase 途中,merge コンフリクト等 formats 外の表示

# %b ブランチ情報
# %a アクション名(mergeなど)
# %c changes
# %u uncommit

# プロンプト表示直前に vcs_info 呼び出し
precmd () { vcs_info }


function rprompt-git-current-branch {
	local name st color gitdir action
	if [[ "$PWD" =~ '/\.git(/.*)?$' ]]; then
		return
	fi
	name=`git rev-parse --abbrev-ref=loose HEAD 2> /dev/null`
	if [[ -z $name ]]; then
		return
	fi


	gitdir=`git rev-parse --git-dir 2> /dev/null`
	action=`VCS_INFO_git_getaction "$gitdir"` && action="($action)"


	st=`git status 2> /dev/null`
	if [[ "$st" =~ "(?m)^nothing to" ]]; then
		color=%F{green}
	elif [[ "$st" =~ "(?m)^nothing added" ]]; then
		color=%F{yellow}
	elif [[ "$st" =~ "(?m)^# Untracked" ]]; then
		color=%B%F{red}
	else
		color=%F{red}
	fi


	echo "$color$name$action%f%b "
}


# PCRE 互換の正規表現を使う
setopt re_match_pcre


# プロンプトが表示されるたびにプロンプト文字列を評価、置換する
setopt prompt_subst


RPROMPT='[`rprompt-git-current-branch`%~]'

# RPROMPT='%{${fg[white]}%}[%~]%{${reset_color}%}'

if [[ ! -n $TMUX ]]; then
  tmux new-session
fi

eval "$(direnv hook zsh)"

function peco-history-selection() {
  BUFFER=`history -n 1 | tac  | awk '!a[$0]++' | peco`
  CURSOR=$#BUFFER
  zle reset-prompt
}

zle -N peco-history-selection
bindkey '^R' peco-history-selection

fpath=(/usr/share/zsh/site-functions $fpath)
