# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh
export TERMINAL=/usr/bin/roxterm
export COLORTERM=roxterm
export TERM=xterm-256color
[ -n "$TMUX" ] && export TERM=screen-256color
export WINEARCH=win32
export WINEPREFIX=$HOME/.win32
export GPGKEY=1AB7B0F8
export VIRTUALENVWRAPPER_PYTHON=/usr/local/bin/python3

# Uncomment the following line to change how often to auto-update (in days).
export UPDATE_ZSH_DAYS=13

ZSH_THEME="muse"
DISABLE_AUTO_UPDATE="true"
ENABLE_CORRECTION="false"
COMPLETION_WAITING_DOTS="true"
DISABLE_UNTRACKED_FILES_DIRTY="true"
plugins=(git autojump colorize common-aliases docker git git-extras git-flow history-substring-search python ssh-agent sudo systemd themes zsh-autosuggestions)

source $ZSH/oh-my-zsh.sh
if [ -f "/usr/local/bin/virtualenvwrapper.sh" ]; then
    source /usr/local/bin/virtualenvwrapper.sh
else
    source /usr/bin/virtualenvwrapper.sh
fi

# Vim mode
bindkey -v

bindkey '^P' up-history
bindkey '^N' down-history
bindkey '^?' backward-delete-char
bindkey '^h' backward-delete-char
bindkey '^w' backward-kill-word
bindkey '^r' history-incremental-search-backward

function zle-line-init zle-keymap-select {
    VIM_PROMPT="%{$fg_bold[yellow]%} [% NORMAL]%  %{$reset_color%}"
    RPS1="${${KEYMAP/vicmd/$VIM_PROMPT}/(main|viins)/} $EPS1"
    zle reset-prompt
}

zle -N zle-line-init
zle -N zle-keymap-select
export KEYTIMEOUT=1

# Alias
alias vi='vim'
alias dmake='cmake -DCMAKE_BUILD_TYPE=Debug ..'
alias vrun='valgrind --leak-check=full --track-origins=yes'
alias keys='ssh-add ~/.ssh/id_home; ssh-add ~/.ssh/id_carbyne; ssh-add ~/.ssh/git_carbyne'
alias rdp='rdesktop -g1300x800'
alias steam-wine='wine ~/.wine/drive_c/Program\ Files\ \(x86\)/Steam/Steam.exe >/dev/null 2>&1 &'
alias npm-do='export PATH=$PATH:$(npm bin)'

alias updev='CURBRANCH=`git rev-parse --abbrev-ref HEAD`; git checkout develop; git pull upstream develop; git checkout $CURBRANCH'
alias uppkg='mono .paket/paket.exe restore; dotnet restore'

alias ad='asciidoctor -r asciidoctor-diagram -r asciidoctor-plantuml -b html5 '

alias python='python3'
alias pip='pip3'

# thefuck
eval $(thefuck --alias)

# fzf via local installation
if [ -e ~/.fzf ]; then
  PATH=$PATH:~/.fzf/bin
  source ~/.fzf/shell/key-bindings.zsh
  source ~/.fzf/shell/completion.zsh
fi

# fzf + ag configuration
if [[ ! -z $(command -v fzf) && ! -z $(command -v ag) ]]; then
  export FZF_DEFAULT_COMMAND='ag --nocolor -g ""'
  export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
  export FZF_ALT_C_COMMAND="$FZF_DEFAULT_COMMAND"
  export FZF_DEFAULT_OPTS='
  --color fg:242,bg:236,hl:65,fg+:15,bg+:239,hl+:108
  --color info:108,prompt:109,spinner:108,pointer:168,marker:168
  '
fi

PROMPT="$fg[cyan]%}$USER@%{$fg[blue]%}%m ${PROMPT}"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
