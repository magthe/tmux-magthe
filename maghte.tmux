#!/usr/bin/env bash

CURRENT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SCRIPTS_DIR="${CURRENT_DIR}/scripts"

    tmux bind-key -r h select-pane -L
    tmux bind-key -r j select-pane -D
    tmux bind-key -r k select-pane -U
    tmux bind-key -r l select-pane -R
fix_pane_nav() {
    for k in C-h C-j C-k C-l Up Down Left Right; do
        tmux unbind-key ${k}
    done
}

fix_pane_resizing() {
    for k in C-Up C-Down C-Left C-Right; do
        tmux unbind-key ${k}
    done
}

fix_window_nav() {
    tmux bind-key -r n next-window
    tmux bind-key -r p previous-window
    for i in $(seq 0 9) C-n C-p M-n M-p; do
        tmux unbind-key ${i}
    done
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
    fix_pane_nav
    fix_pane_resizing
    fix_window_nav
    fix_window_splitting
    set_window_renaming
    set_my_copying
}

main
