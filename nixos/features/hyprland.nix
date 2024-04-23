{ config, pkgs, lib, ... }: {
  options = { hyprland.enable = lib.mkEnableOption "enables hyprland desktop"; };
  config = lib.mkIf config.hyprland.enable {
    programs.hyprland = {
     enable = true; 
     nvidiaPatches = true;
     xwayland.enable = true;
    };
    environment.sessionVariables = {
      NIXOS_OZONE_WL = "1";
    };
    hardware = {
      opengl.enable = true;
      nvidia.modesetting.enable = true;
    };
    environment.systemPackages = with pkgs [
      waybar
      (waybar.overrideAttrs (oldAttrs: {
        mesonFlags = oldAttrs.mesonFlags ++ [ "-Dexperimental=true" ];
        })
      )
      mako
      swww
      libnotify
      kitty
      rofi-wayland
    ];
    xdg.portal = {
      enable = true;
      extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
    };

  };
}
