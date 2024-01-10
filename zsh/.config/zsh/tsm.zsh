#!/bin/zsh                                                                                                   

SESSIONNAME="devapi"
tmux has-session -t $SESSIONNAME &> /dev/null

if [ $? != 0 ] 
 then
    tmux new-session -s $SESSIONNAME -c ~/Idals/API/RefactorAPI -d
    tmux send-keys -t $SESSIONNAME "tmux splitw" C-m
    sleep 5
    tmux send-keys -t $SESSIONNAME "tmux select-layout main-vertical" C-m
    # tmux select-pane -t $SESSIONNAME:1.0
    tmux send-keys -t $SESSIONNAME:1.0 "nvim src/index.ts" C-m
    # tmux select-pane -t $SESSIONNAME:1.1
    tmux send-keys -t $SESSIONNAME:1.1 "pnpm test" C-m
    tmux select-pane -t $SESSIONNAME:1.0
fi

tmux attach -t $SESSIONNAME
