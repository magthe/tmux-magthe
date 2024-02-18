#!/usr/bin/env bash

CURRENT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SCRIPTS_DIR="${CURRENT_DIR}/scripts"

fix_pane_navigation_bindings() {
    tmux unbind-key C-h
    tmux unbind-key C-j
    tmux unbind-key C-k
    tmux unbind-key C-l
    tmux bind-key -r h select-pane -L
    tmux bind-key -r j select-pane -D
    tmux bind-key -r k select-pane -U
    tmux bind-key -r l select-pane -R
}

fix_window_nav() {
    tmux unbind-key C-n
    tmux unbind-key C-p
    tmux bind-key -r n next-window
    tmux bind-key -r p previous-window
}

fix_window_splitting() {
    tmux unbind-key '"'
    tmux unbind-key '%'
}

set_window_renaming() {
    tmux set-option -g status-interval 1
    tmux set-option -g automatic-rename on
    tmux set-option -g automatic-rename-format '#{b:pane_current_path}'
}

set_my_copying() {
    tmux unbind-key '['
    tmux unbind-key ']'

    tmux bind-key '[' run-shell "${SCRIPTS_DIR}/edit-tmux-output"
}

main() {
    fix_pane_navigation_bindings
    fix_window_nav
    fix_window_splitting
    set_window_renaming
    set_my_copying
}

main
