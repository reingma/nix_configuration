{
  writeShellScriptBin,
  tmux,
  fd,
  fzf,
}:
writeShellScriptBin "tsession" ''
  if [[ $# -eq 1 ]]; then
    selected_path=$1
  else
    selected_path=$(fd . ~/dev --min-depth 1 --maxdepth 2 --type d | fzf)
  fi

  if [[ -z $selected_path ]]; then
    exit 0
  fi

  session_name=$(basename "$selected_path" | tr . _)
  tmux_running=$(pgrep tmux)

  if [[ -z $TMUX ]] && [[ -z $tmux_running ]]; then
    tmux new-session -s $session_name -c $selected_path
    exit 0
  fi

  if ! tmux has-session -t=$session_name 2> /dev/null; then
    tmux new-session -ds $session_name -c $selected_path
  fi

  tmux switch-client -t $session_name
''
