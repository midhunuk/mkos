#!/bin/sh

SESSION="learn_c"

# Check if the session already exists
tmux has-session -t $SESSION 2>/dev/null
if [ $? -eq 0 ]; then
  echo "Session $SESSION already exists. Attaching..."
  tmux attach -t $SESSION
  exit 0
fi

# Create a new session, window 1 
echo "Creating session $SESSION ..."

tmux new-session -d -s $SESSION -n editor -c ~/git_repo/adhyayana-c

tmux send-keys -t $SESSION 'nvim ~/git_repo/adhyayana-c' C-m

tmux new-window -t $SESSION:2 -n workspace -c ~/git_repo/adhyayana-c

# Select main pane
tmux select-window -t $SESSION:1

# Attach to the session
tmux attach -t $SESSION

