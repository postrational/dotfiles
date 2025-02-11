load_command_not_found_handler() {
  local file

  for file in \
    /usr/share/doc/pkgfile/command-not-found.zsh \
    /opt/homebrew/Library/Taps/homebrew/homebrew-command-not-found/handler.sh \
    /usr/local/Homebrew/Library/Taps/homebrew/homebrew-command-not-found/handler.sh \
    /home/linuxbrew/.linuxbrew/Homebrew/Library/Taps/homebrew/homebrew-command-not-found/handler.sh; do
    [[ -r "$file" ]] && source "$file" && return 0
  done

  if [[ -x /usr/lib/command-not-found ]]; then
    command_not_found_handler() { /usr/lib/command-not-found -- "$1"; return $?; }
    return 0 # Indicate success
  elif [[ -x /usr/share/command-not-found/command-not-found ]]; then
    command_not_found_handler() { /usr/share/command-not-found/command-not-found -- "$1"; return $?; }
    return 0 # Indicate success
  fi

  # No command-not-found handler found, falling back to default.
  command_not_found_handler() {
    printf "zsh: command not found: %s\n" "$1" >&2
    return 127
  }
  print -n $'\e[33m' >&2 # Yellow color
  print "Warning: No command-not-found handler found." >&2
  print -n $'\e[0m' >&2  # Reset color
}

load_command_not_found_handler
unset -f load_command_not_found_handler

