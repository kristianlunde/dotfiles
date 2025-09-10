# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

export ZSH="$HOME/.oh-my-zsh"

#ZSH_THEME="agnosterzak"
ZSH_THEME="robbyrussel"

plugins=( 
    git
    dnf
    zsh-autosuggestions
    zsh-syntax-highlighting
    fzf-tab
)

source $ZSH/oh-my-zsh.sh

# check the dnf plugins commands here
# https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/dnf


# Display Pokemon-colorscripts
# Project page: https://gitlab.com/phoneybadger/pokemon-colorscripts#on-other-distros-and-macos
#pokemon-colorscripts --no-title -s -r #without fastfetch
#pokemon-colorscripts --no-title -s -r | fastfetch -c $HOME/.config/fastfetch/config-pokemon.jsonc --logo-type file-raw --logo-height 10 --logo-width 5 --logo -

# fastfetch. Will be disabled if above colorscript was chosen to install
fastfetch -c $HOME/.config/fastfetch/config-compact.jsonc

# Set-up FZF key bindings (CTRL R for fuzzy history finder)
source <(fzf --zsh)

HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt appendhistory

# Set-up icons for files/directories in terminal using lsd
alias ls='lsd'
alias l='ls -l'
alias la='ls -a'
alias lla='ls -la'
alias lt='ls --tree'


alias cat="bat"
alias v="vim"
alias n="nvim"
alias s3="aws s3"
alias cd..="cd .."

#Docker aliases
alias dcup="docker-compose up -d"
alias dcstop="docker-compose stop"
alias dcupb="docker-compose up -d --build"
alias dcps="docker-compose ps"

function dce {
	docker-compose exec "$1" bash;
}

#laravel sail
alias sail="[ -f sail] && bash sail || bash vendor/bin/sail"

#fzf config
export FZF_DEFAULT_OPTS="--height 80% --reverse --border --preview 'bat --style=numbers --color=always {}'"
# Set up fzf key bindings and fuzzy completion
source <(fzf --zsh)
