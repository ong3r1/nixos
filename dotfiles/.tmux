# Improve colours
set -g default-terminal 'screen-256color'
set-option -sa terminal-overrides ',xterm-256color:Tc'

# QoL
set -g set-clipboard on
set -g mouse on

# vim key bindings
bind-key h select-pane -L
bind-key j select-pane -D
bind-key k select-pane -U
bind-key l select-pane -R
bind-key -r C-h select-window -t :-
bind-key -r C-l select-window -t :+

unbind C-b
set -g prefix2 C-Space

# Reload config
unbind r
bind r source-file ~/.tmux.conf

# Status position
set-option -g status-position top

# List of plugins
set -g @plugin 'tmux-plugins/tpm'
set -g @plugin 'tmux-plugins/tmux-sensible'

# Theme
set -g @plugin 'niksingh710/minimal-tmux-status'

# Colours
set -g @minimal-tmux-fg "#3c3836"
set -g @minimal-tmux-bg "#fbf1c7"

# set -g @minimal-tmux-bg "#${config.stylix.base16Scheme.base01}" (or you can use it with pywal)
set -g @minimal-tmux-use-arrow true
set -g @minimal-tmux-right-arrow ""
set -g @minimal-tmux-left-arrow ""

# Initialise TMUX plugin manager (This line should be at the bottom of .tmux.conf)
run '~/.tmux/plugins/tpm/tpm'
