TMUX_WINDOW_ID="$(tmux list-windows -F '#{window_id}_#{?window_active,A,I}' | grep _A | sed 's/[^0-9]//g')"
NVIM_LISTEN_ADDRESS="/tmp/nvim-tmux-$TMUX_WINDOW_ID"
