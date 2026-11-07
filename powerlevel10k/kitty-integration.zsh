# Powerlevel10k integration for Kitty.
#
# Add this line inside ~/.p10k.zsh, immediately after the
# `unset -m '(POWERLEVEL9K_*|DEFAULT_USER)...'` line:
#
#   source "$HOME/kitty-configs/powerlevel10k/kitty-integration.zsh"
#
# This enables Powerlevel10k's terminal shell integration only under Kitty.
# It prevents prompt redraw artifacts when the window is resized.

if [[ $TERM == xterm-kitty ]]; then
  typeset -g POWERLEVEL9K_TERM_SHELL_INTEGRATION=true
fi
