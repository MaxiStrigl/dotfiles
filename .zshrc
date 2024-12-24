if [ -z "$TMUX" ] && ! tmux ls &>/dev/null; then
  tmux
fi


export MANPAGER="sh -c 'col -bx | bat -l man -p'"
export MANROFFOPT="-c"

export PATH=$PATH:/home/maxi/Projects/Spotparse/

setopt HIST_IGNORE_SPACE


#Set the directory to store zinit and it's plugins
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

export COLORTERM=truecolor

#Download zinit if it doesn't exist
if [ ! -d "$ZINIT_HOME" ]; then
  mkdir -p "$(dirname $ZINIT_HOME)"
  git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

#Load zinit
source "${ZINIT_HOME}/zinit.zsh"

zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
zinit light Aloxaf/fzf-tab

#Add snippets
zinit snippet OMZP::git
zinit snippet OMZP::sudo
zinit snippet OMZP::archlinux
zinit snippet OMZP::tldr

#Load completions
autoload -Uz compinit && compinit

#Completion settings
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no

eval "$(oh-my-posh init zsh --config $HOME/.config/ohmyposh/custom.toml)"
eval $(thefuck --alias)

#Keybinds
bindkey '^f' autosuggest-accept
bindkey '^n' history-search-forward
bindkey '^p' history-search-backward

#Aliases
alias cd='z'
alias v='nvim'
alias c='clear'
alias python='python3'
alias cat='bat'
alias t='tmux'
alias ls='lsd'
alias lg='lazygit'
alias diff='delta'
alias src='source ~/.zshrc'
# alias ls='ls --color'

# Obsidian
alias oo='cd $HOME/Projects/obsidianVault/New'
alias or='nvim $HOME/Projects/obsidianVault/New/inbox/*.md'
alias on='bash $HOME/Projects/obsidianVault/scripts/on'

#Shell integration

# Custom Commands
st() {
  echo "Battery Status:"
  acpi
  echo -e "\nCurrent Date and Time:"
  date
  echo -e "\nNetwork Connection Status:"
  nmcli connection show --active
}

#History
HISTSIZE=5000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups


# BEGIN opam configuration
# This is useful if you're using opam as it adds:
#   - the correct directories to the PATH
#   - auto-completion for the opam binary
# This section can be safely removed at any time if needed.
[[ ! -r '/home/maxi/.opam/opam-init/init.zsh' ]] || source '/home/maxi/.opam/opam-init/init.zsh' > /dev/null 2> /dev/null
# END opam configuration

# bun completions
[ -s "/home/maxi/.bun/_bun" ] && source "/home/maxi/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

unalias zi
# Shell integrations
eval "$(fzf --zsh)"
eval "$(zoxide init zsh)"



export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion


if [ -z "$NVIM" ]; then
	st
fi

eval $(thefuck --alias)
