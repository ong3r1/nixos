{
  config,
  pkgs,
  ...
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
    '';
  };
}
