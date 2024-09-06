{
  config,
  lib,
  pkgs,
  ...
}:
let
  inherit (config.colorScheme) palette;
in
{
  options = {
    tmux.enable = lib.mkEnableOption "enable tmux";
  };
  config = lib.mkIf config.tmux.enable {
    programs.tmux = {
      enable = true;
      baseIndex = 1;
      plugins = with pkgs; [ tmuxPlugins.vim-tmux-navigator ];
      extraConfig = ''
        set-option -sa terminal-overrides ",xterm*:Tc"
        set -g @catppuccin_flavor 'mocha'
      '';
    };
  };
}
