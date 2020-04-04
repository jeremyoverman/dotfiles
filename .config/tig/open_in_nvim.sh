#!/bin/bash

source ~/.tmux/set_nvim_address.sh
source ~/.zshrc_unmanaged

echo "Opening file in nvim..."
nvr --servername $NVIM_LISTEN_ADDRESS $1
tmux select-pane -t 1
