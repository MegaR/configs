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
#zinit ice as"completion"
#zinit snippet OMZP::adb/_adb
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
    worktree=`git worktree list | awk '{print $1}' | fzf -1 --query "$1"`
    cd "${worktree}"
}

export function wtlist() {
    git worktree list | awk '{
        # Extract the last part of the path
        split($1, path_parts, "/")
        print path_parts[length(path_parts)]
    }'
}

export function wtadd() {
    git fetch

    # Store the full argument
    branch_name="$@"

    # Check if the branch already exists remotely
    if git ls-remote --heads origin "$branch_name" | grep -q "$branch_name"; then
        echo "Adding worktree for existing branch: $branch_name"
        git worktree add "$branch_name" "$branch_name"
    else
        echo "Creating new branch: $branch_name"
        git worktree add -b "$branch_name" "$branch_name" origin/main
    fi

    # Change to the new worktree
    cd "$branch_name"
}
export function wtremove() {
    # Get full worktree path and branch name
    worktree_info=$(git worktree list | fzf -1 --query "$1")
    if [[ -z "$worktree_info" ]]; then
        echo "No worktree selected"
        return 1
    fi

    # Extract path and branch from the selected line
    worktree_path=$(echo "$worktree_info" | awk '{print $1}')
    branch=$(echo "$worktree_info" | awk '{print $3}' | sed 's/[][]//g')

    # Get directory name for display
    dir_name=$(basename "$worktree_path")

    echo "Deleting worktree $dir_name (branch: $branch)"
    git worktree remove "$dir_name"
    git branch -d "$branch"
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
    git config --global init.defaultBranch main
    git config --global pull.rebase false
fi

eval "$(zoxide init --cmd cd zsh)"
# eval "$(starship init zsh)"
eval "$(fzf --zsh)"

if [ "$TERM_PROGRAM" != "Apple_Terminal" ]; then
    eval "$(oh-my-posh init zsh --config $HOME/.config/ohmyposh/base.yaml)"
fi

# Wezterm
source "${HOME}/.config/wezterm.sh"
