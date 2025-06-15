{ config, pkgs, ... }:

{
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

      # Base status bar colours (Gruvbox dark)
      set -g status on
      set -g status-interval 5
      set -g status-justify centre
      set -g status-style bg=colour235,fg=colour223

      # Window status
      setw -g window-status-format " #I:#W "
      setw -g window-status-current-format "#[bg=colour239,fg=colour223]#[bg=colour239,fg=colour223,bold] #I:#W #[bg=colour235,fg=colour239,nobold]"
      setw -g window-status-style bg=colour235,fg=colour244
      setw -g window-status-current-style bg=colour239,fg=colour223,bold

      # Pane border
      set -g pane-border-style fg=colour239
      set -g pane-active-border-style fg=colour250

      # Message text (when searching or confirming)
      set -g message-style bg=colour239,fg=colour223

      # Command prompt colours
      set -g message-command-style bg=colour239,fg=colour223

      # Status Left & Right
      set -g status-left "#[bg=colour239,fg=colour223,bold] #S #[bg=colour235,fg=colour239,nobold]"
      set -g status-left-length 40

      set -g status-right "#[bg=colour235,fg=colour239]#[bg=colour239,fg=colour223] %Y-%m-%d  %H:%M #[default]"
      set -g status-right-length 100

      # Mode-style (copy-mode selection)
      set -g mode-style bg=colour239,fg=colour223

      # Bell
      set -g visual-bell on
      set -g bell-action any
    '';
  };

}
