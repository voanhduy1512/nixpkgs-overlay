{ writeShellScriptBin, tmux }:

writeShellScriptBin "tat" ''
  path_name="$(basename "$PWD" | tr . -)"
  session_name=''${1-$path_name}

  not_in_tmux() {
    [ -z "$TMUX" ]
  }

  session_exists() {
    ${tmux}/bin/tmux has-session -t "=$session_name"
  }

  create_detached_session() {
    (TMUX="" ${tmux}/bin/tmux new-session -Ad -s "$session_name")
  }

  create_if_needed_and_attach() {
    if not_in_tmux; then
      ${tmux}/bin/tmux new-session -As "$session_name"
    else
      if ! session_exists; then
        create_detached_session
      fi
      ${tmux}/bin/tmux switch-client -t "$session_name"
    fi
  }

  create_if_needed_and_attach
''
