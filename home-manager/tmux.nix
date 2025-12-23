{ config
, pkgs
, ...
}: {
  programs.tmux = {
    enable = true;

    # Set your prefix key and other sane defaults
    keyMode = "vi";
    terminal = "screen-256color";

    extraConfig = ''
      # Quality of Life
      set -g mouse on
      set -g set-clipboard on
      set -g default-terminal "screen-256color"
      set-option -sa terminal-overrides ',xterm-256color:Tc'

      # Vim style navigation
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

      # Bell
      set -g visual-bell on
      set -g bell-action any

      # Colours
      # Status bar
      set -g status-style fg=colour7,bg=colour0

      # Left side (session name)
      set -g status-left-style fg=colour4,bg=colour0
      set -g status-left "#S "

      # Right side
      set -g status-right-style fg=colour6,bg=colour0
      set -g status-right "%Y-%m-%d %H:%M"

      # Active window
      set -g window-status-current-style fg=colour0,bg=colour4
      set -g window-status-current-format " #I:#W "

      # Inactive windows
      set -g window-status-style fg=colour7,bg=colour0
      set -g window-status-format " #I:#W "

      # Pane borders
      set -g pane-border-style fg=colour8
      set -g pane-active-border-style fg=colour4

      # Messages
      set -g message-style fg=colour0,bg=colour3

    '';
  };
}
