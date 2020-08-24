# BUILT INS
alias ll='ls -alh --color=auto'

# GIT
alias gitlog="git log --graph --all --decorate" 

# TMUX
alias tmux4="tmux -u new-session -s quad \; split-window -h\; split-window -v\; select-pane -L\; split-window -v\; send-keys -t top-left 'C-l'\; send-keys -t top-right 'C-l'\; send-keys -t bottom-left 'C-l'\; send-keys -t bottom-right 'C-l'\; select-pane -U\;"
alias tmuxrpis="tmux -u new-session -s rpis \; split-window -h\; split-window -v\; select-pane -L\; split-window -v\; send-keys -t top-left 'ssh jeff@triforce' 'C-m'\; send-keys -t top-right 'ssh jeff@link' 'C-m'\; send-keys -t bottom-left 'ssh jeff@zelda' 'C-m'\; send-keys -t bottom-right 'ssh jeff@ganon' 'C-m'\; select-pane -U\; set-window-option synchronize-panes\; send-keys 'C-l'\;"
