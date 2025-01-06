#!/usr/bin/env bash

CURRENT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SCRIPTS_DIR="${CURRENT_DIR}/scripts"

fix_pane_nav() {
    for k in C-h C-j C-k C-l Up Down Left Right; do
        tmux unbind-key ${k}
    done
    tmux bind-key -r -N 'Select the pane to the left' h select-pane -L
    tmux bind-key -r -N 'Select the pane below' j select-pane -D
    tmux bind-key -r -N 'Select the pane above' k select-pane -U
    tmux bind-key -r -N 'Select the pane to the right' l select-pane -R
}

fix_pane_resizing() {
    for k in C-Up C-Down C-Left C-Right; do
        tmux unbind-key ${k}
    done
}

fix_window_nav() {
    for i in $(seq 0 9) C-n C-p M-n M-p; do
        tmux unbind-key ${i}
    done
    tmux bind-key -r -N 'Select next window' n next-window
    tmux bind-key -r -N 'Select previous window' p previous-window
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

add_notes() {
    # https://github.com/tmux-plugins/tpm/pull/187 -- I'm using the default bindings
    tmux bind-key -N 'TPM: Install plugins' I
    tmux bind-key -N 'TPM: Update plugins' U
    tmux bind-key -N 'TPM: Prune plugins' M-u
}

main() {
    fix_pane_nav
    fix_pane_resizing
    fix_window_nav
    fix_window_splitting
    set_window_renaming
    set_my_copying
    add_notes
}

main
