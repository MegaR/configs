eval "$(starship init bash)"
eval "$(zoxide init --cmd cd bash)"

bind 'set completion-ignore-case on'
alias lg='lazygit'
alias ls='eza --icons=always'
alias ll='eza -alh --icons=always'
alias tree='eza --tree --icons=always'

alias less='bat'
alias cat='bat -pp'

if command -v fzf-share >/dev/null; then
  source "$(fzf-share)/key-bindings.bash"
  source "$(fzf-share)/completion.bash"
  source ~/.config/fzf-bash-completion.sh
  bind -x '"\t": fzf_bash_completion'
fi
