eval "$(starship init bash)"
eval "$(zoxide init --cmd cd bash)"

bind 'set completion-ignore-case on'
alias lg='lazygit'

if command -v fzf-share >/dev/null; then
  source "$(fzf-share)/key-bindings.bash"
  source "$(fzf-share)/completion.bash"
fi
