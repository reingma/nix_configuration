{ lib, pkgs, config, ... }: {
  options = { desktop.enable = lib.mkEnableOption "enables desktop"; };
  imports = [ ./hyprland ];
  config =
    lib.mkIf config.desktop.enable { hyprland.enable = lib.mkDefault true; };
}
