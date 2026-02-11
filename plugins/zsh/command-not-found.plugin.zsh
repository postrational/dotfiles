load_command_not_found_handler() {
  local handler
  local -a source_handlers=(
    /usr/share/doc/pkgfile/command-not-found.zsh
  )
  local -a exec_handlers=(
    /usr/lib/command-not-found
    /usr/share/command-not-found/command-not-found
  )

  if (( $+commands[brew] )); then
    source_handlers+=("$(brew --repository)/Library/Homebrew/command-not-found/handler.sh")
  fi

  for handler in "${source_handlers[@]}"; do
    [[ -r "$handler" ]] && source "$handler" && return 0
  done

  for handler in "${exec_handlers[@]}"; do
    if [[ -x "$handler" ]]; then
      local cmd="$handler"
      command_not_found_handler() { "$cmd" -- "$1"; return $?; }
      return 0
    fi
  done

  command_not_found_handler() {
    print "zsh: command not found: $1" >&2
    return 127
  }

  print -P "%F{yellow}Warning: No command-not-found handler found.%f" >&2
  return 1
}

load_command_not_found_handler
unset -f load_command_not_found_handler