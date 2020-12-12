# BUILT INS
alias ll='ls -alh --color=auto'

# GIT
alias gitlog="git log --graph --all --decorate" 

# TMUX
alias tmux4="tmux -u new-session -s quad \; split-window -h\; split-window -v\; select-pane -L\; split-window -v\; send-keys -t top-left 'C-l'\; send-keys -t top-right 'C-l'\; send-keys -t bottom-left 'C-l'\; send-keys -t bottom-right 'C-l'\; select-pane -U\;"
alias tmux6="tmux -u new-session -s hex \; split-window -v\; split-window -v\; split-window -h\; select-pane -U\; split-window -h\; select-pane -U\; split-window -h\; select-pane -L\; select-layout tiled\; set-window-option synchronize-panes\; send-keys 'C-l'\;"
alias tmuxrpis="tmux -u new-session -s rpis \; split-window -h\; split-window -v\; select-pane -L\; split-window -v\; send-keys -t top-left 'ssh jeff@triforce' 'C-m'\; send-keys -t top-right 'ssh jeff@link' 'C-m'\; send-keys -t bottom-left 'ssh jeff@zelda' 'C-m'\; send-keys -t bottom-right 'ssh jeff@ganon' 'C-m'\; select-pane -U\; set-window-option synchronize-panes\; send-keys 'C-l'\;"
alias tmuxt620s="tmux -u new-session -s t620s \; split-window -v\; split-window -v\; split-window -h\; select-pane -U\; split-window -h\; select-pane -U\; split-window -h\; select-pane -L\; select-layout tiled\; send-keys -t 0 'ssh jeff@a-baby' 'C-m'\; send-keys -t 1 'ssh jeff@guy1' 'C-m'\; send-keys -t 2 'ssh jeff@guy2' 'C-m'\; send-keys -t 3 'ssh jeff@guy3' 'C-m'\; send-keys -t 4 'ssh jeff@guy4' 'C-m'\; send-keys -t 5 'ssh jeff@guy5' 'C-m'\; set-window-option synchronize-panes\; send-keys 'C-l'\;"
