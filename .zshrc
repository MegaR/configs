# Set the directory we want to store zinit and plugins
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

# Download Zinit, if it's not there yet
if [ ! -d "$ZINIT_HOME" ]; then
    mkdir -p "$(dirname $ZINIT_HOME)"
    git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

# Source/Load zinit
source "${ZINIT_HOME}/zinit.zsh"

# # Zsh plugins
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
zinit light Aloxaf/fzf-tab

# # Add snippets
# Use zi ice as'completion' to directly add single file completion snippets
# Use zi ice svn if a plugin/snippet requires an entire subdirectory
zinit snippet OMZP::git
zinit snippet OMZP::command-not-found
zinit ice as"completion"
zinit snippet OMZP::adb/_adb
zinit ice as"completion"
zinit snippet OMZP::docker
zinit ice as"completion"
zinit snippet OMZP::docker-compose/_docker-compose
zinit snippet OMZP::gradle
zinit ice as"completion"
zinit snippet OMZP::rust/_rustc
zinit snippet OMZP::ssh

# Custom completions
function customCompletion () {
    if (( ! ${+commands[$1]} )); then
        return
    fi
    eval "$2 >| ~/.local/share/zinit/completions/_$1 &|"
}

customCompletion "kubectl" "kubectl completion zsh"
customCompletion "gh" "gh completion -s zsh"
customCompletion "bun" "bun completions"

# Load completions
autoload -Uz compinit && compinit
zinit cdreplay -q

# Keybindings
bindkey '^y' autosuggest-accept
bindkey '^p' history-search-backward
bindkey '^n' history-search-forward
bindkey "^[[1;5C" forward-word
bindkey "^[[1;5D" backward-word

# History
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
setopt hist_find_no_dups

# Completion styling
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' menu no
eza_preview='eza -1 --icons=always --color=always $realpath'
bat_preview='bat -pp --color=always --line-range :100 $realpath'
zstyle ':fzf-tab:complete:cd:*' fzf-preview "$eza_preview"
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview "$eza_preview"
zstyle ':fzf-tab:complete:ls:*' fzf-preview "$bat_preview 2> /dev/null || $eza_preview"
zstyle ':fzf-tab:complete:eza:*' fzf-preview "$bat_preview 2> /dev/null || $eza_preview"
zstyle ':fzf-tab:complete:cat:*' fzf-preview "$bat_preview 2> /dev/null || $eza_preview"
zstyle ':fzf-tab:complete:bat:*' fzf-preview "$bat_preview 2> /dev/null || $eza_preview"

# Completion caching
zstyle ':completion:*' accept-exact '*(N)'
zstyle ':completion:*' use-cache yes
zstyle ':completion:*' cache-path $ZSH_CACHE_DIR

# Aliases
alias lg='lazygit'
alias ld='lazydocker'
alias nix-shell='nix-shell --run zsh'

alias ls='eza --icons=always'
alias ll='eza -alh --icons=always'
alias tree='eza --tree --icons=always'

alias less='bat'
alias cat='bat -pp'

alias pbcopy='xclip -selection clipboard'
alias pbpaste='xclip -selection clipboard -o'

# functions
export function wt() {
    worktree=`git worktree list | cut -d ' ' -f1 | fzf -1 --query "$1"`
    cd ${worktree}
}
export function wtlist() {
    git worktree list | cut -d / -f6 | cut -d ' ' -f1
}
export function wtadd() {
    cd main
    git pull origin main
    cd ..

    git worktree add "$@" --guess-remote
    cd $1
    git branch --set-upstream-to=origin/$1 $1 || true
}
export function wtremove() {
    worktree=`git worktree list | cut -d / -f6 | cut -d ' ' -f1 | fzf -1 --query "$1"`
    echo "Deleting worktree $worktree"
    git worktree remove $worktree
    git branch -d $worktree
}

# Vars
export VISUAL=nvim
export EDITOR="$VISUAL"
export FZF_DEFAULT_OPTS=$FZF_DEFAULT_OPTS'
    --color=fg:#e5e9f0,bg:-1,hl:#81a1c1
    --color=fg+:#e5e9f0,bg+:-1,hl+:#81a1c1
    --color=info:#eacb8a,prompt:#bf6069,pointer:#b48dac
    --color=marker:#a3be8b,spinner:#b48dac,header:#a3be8b'

# Tools
if command -v git >/dev/null; then
    git config --global rerere.enabled true
    git config --global diff.algorithm histogram
fi

eval "$(zoxide init --cmd cd zsh)"
# eval "$(starship init zsh)"
eval "$(fzf --zsh)"

if [ "$TERM_PROGRAM" != "Apple_Terminal" ]; then
    eval "$(oh-my-posh init zsh --config $HOME/.config/ohmyposh/base.yaml)"
fi

# Wezterm
source "${HOME}/.config/wezterm.sh"
