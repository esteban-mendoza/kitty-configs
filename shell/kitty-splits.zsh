# Kitty-only pane splitting helpers for Zsh.
# Install this file as ~/.config/kitty/kitty-splits.zsh and source it from
# ~/.zshrc:
#
#   source "$HOME/.config/kitty/kitty-splits.zsh"
#
# Usage:
#   sp             split below the current pane
#   spr            split to the right of the current pane
#   spl            split to the left of the current pane
#   sp htop        split below and run htop
#
# The helpers preserve the current working directory and require Kitty's
# remote control to be enabled. The included kitty.conf handles that.

_kitty_split() {
  emulate -L zsh

  local location="${1:-hsplit}"
  if (( $# )); then
    shift
  fi

  if [[ -z ${KITTY_WINDOW_ID:-} ]]; then
    print -u2 -- '_kitty_split: this command must be run inside Kitty'
    return 1
  fi

  command kitten @ launch --self \
    --source-window="id:${KITTY_WINDOW_ID}" \
    --next-to="id:${KITTY_WINDOW_ID}" \
    --location="${location}" \
    --cwd=current \
    "$@"
}

alias sp='_kitty_split hsplit'
alias spr='_kitty_split vsplit'
alias spl='_kitty_split before'
