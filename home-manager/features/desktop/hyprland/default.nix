{ config, lib, pkgs, ... }: {
  options = { hyprland.enable = lib.mkEnableOption "enable hyprland desktop"; };
  imports = [ ../common ../common/wayland ];
  config = lib.mkIf config.hyprland.enable {
    wayland.windowManager.hyprland = { enable = true; };
  };
}
