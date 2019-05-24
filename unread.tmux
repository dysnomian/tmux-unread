#!/usr/bin/env bash

CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

MAIL_ICON=""
UNREAD_ICON=""
ERROR_ICON=""

# TODO: script to fetch unread count from Gmail
unread_count="$($CURRENT_DIR/scripts/unread.sh)"

# TODO unread boolean
# TODO error detection

mail_icon_interpolation="\#{mail_icon}"
error_icon_interpolation="\#{error_icon}"
unread_icon_interpolation="\#{unread_icon}"
unread_count_interpolation="\#{unread_count}"
unread_string_interpolation="\#{unread_string}"

do_interpolation() {
  local output="$1"
  local output="${output/$mail_icon_interpolation/$MAIL_ICON}"
  local output="${output/$unread_count_interpolation/$unread_count}"
  echo "$output"
}

update_tmux_uptime() {
  local option="$1"
  local option_value="$(get_tmux_option "$option")"
  local new_option_value="$(do_interpolation "$option_value")"
  set_tmux_option "$option" "$new_option_value"
}


main() {
  update_tmux_uptime "status-right"
  update_tmux_uptime "status-left"
}
main
