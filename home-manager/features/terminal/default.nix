{ lib, config, ... }: {
  options = { terminal.enable = lib.mkEnableOption "enables custom terminal"; };
  imports = [ ./kitty.nix ./shell ./zellij.nix ./tmux.nix];
  config = lib.mkIf config.terminal.enable {
    kitty.enable = lib.mkDefault true;
    zsh.enable = lib.mkDefault true;
    zellij.enable = lib.mkDefault true;
    tmux.enable = lib.mkDefault false;
  };
}
