{ lib, config, ... }: {
  options = { terminal.enable = lib.mkEnableOption "enables custom terminal"; };
  imports = [ ./shell ./zellij.nix ./tmux.nix ];
  config = lib.mkIf config.terminal.enable {
    zsh.enable = lib.mkDefault true;
    zellij.enable = lib.mkDefault true;
    tmux.enable = lib.mkDefault false;
  };
}
