NAME=$1; shift;
COMMAND=$@
PANE_ID=$(tmux show -wqv @bottomPaneId)

if [ -n "$PANE_ID" ] && tmux lsp -F'#{pane_id}' | grep -q ^$PANE_ID; then
    tmux killp -t $PANE_ID
    tmux set -wu @bottomPaneId
else
    tmux set -wu @bottomPaneName
fi

CURRENT_NAME=$(tmux show -wqv @bottomPaneName)

if [ "$CURRENT_NAME" != "$NAME" ]; then
    PANE_ID=$(tmux select-pane -t 1 && tmux split-window -v -t 1 -l 25 -c "#{pane_current_path}" -PF"#{pane_id}" $COMMAND)

    tmux set -w @bottomPaneId "$PANE_ID"
    tmux set -w @bottomPaneName "$NAME"
else
    if [ -n "$CURRENT_NAME" ]; then
        tmux set -wu @bottomPaneName
    fi
fi
