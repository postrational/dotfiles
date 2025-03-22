# Function to load command-not-found handler
load_command_not_found_handler() {
  # Check if we're in a Homebrew environment
  if command -v brew &>/dev/null; then
    if brew command command-not-found-init &>/dev/null; then
      eval "$(brew command-not-found-init)"
      return 0
    fi
  fi
  
  # Fall back to Linux-style handlers if available
  if [[ -x /usr/lib/command-not-found ]]; then
    command_not_found_handler() { /usr/lib/command-not-found -- "$1"; return $?; }
    return 0
  elif [[ -x /usr/share/command-not-found/command-not-found ]]; then
    command_not_found_handler() { /usr/share/command-not-found/command-not-found -- "$1"; return $?; }
    return 0
  elif [[ -r /usr/share/doc/pkgfile/command-not-found.zsh ]]; then
    source /usr/share/doc/pkgfile/command-not-found.zsh
    return 0
  fi
  
  # If we get here, no handler was found
  command_not_found_handler() {
    echo "my zsh: command not found: $1" >&2
    return 127
  }
  
  print -n $'\e[33m' >&2 # Yellow color
  print "Warning: No command-not-found handler found." >&2
  print -n $'\e[0m' >&2 # Reset color
  return 1
}

# Load the handler
load_command_not_found_handler
unset -f load_command_not_found_handler
