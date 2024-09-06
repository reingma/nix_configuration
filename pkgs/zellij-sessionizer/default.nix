{
  writeShellScriptBin,
  zellij,
  fd,
  fzf,
}:
writeShellScriptBin "zsession" ''
  if [[ $# -eq 1 ]]; then
    selected_path=$1
  else
    selected_path=$(fd . ~/dev --min-depth 0 --maxdepth 1 --type d | cat - <(echo "~/.sys_config") | fzf)
  fi

  if [[ -z $selected_path ]]; then
    exit 0
  fi

  session_name=$(basename "$selected_path" | tr . _)

  if [[ -z $ZELLIJ ]]; then
    cd $selected_path
    zellij attach --create $session_name
    exit 0
  fi

  zellij action new-pane
  zellij action write-chars "cd $selected_path" && zellij action write 10
''
