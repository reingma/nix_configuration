{ config, lib, pkgs, ... }:
let
  hyprland =
    pkgs.inputs.hyprland.hyprland.override { wrapRuntimeDeps = false; };
  xdph = pkgs.inputs.hyprland.xdg-desktop-portal-hyprland.override {
    inherit hyprland;
  };
in {
  options = { hyprland.enable = lib.mkEnableOption "enable hyprland desktop"; };
  config = lib.mkIf config.hyprland.enable {
    imports = [ ../common ../common/wayland ];
    xdg.portal = {
      extraPortal = [ xdph ];
      configPackages = [ hyprland ];
    };
    wayland.windowManager.hyprland = {
      enable = true;
      package = hyprland;
    };
  };
}
