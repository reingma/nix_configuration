{ inputs, pkgs, lib, config, ... }:
let
  hyprland = inputs.hyprland.packages.${pkgs.system}.hyprland.override {
    wrapRuntimeDeps = false;
  };
  hyprbars =
    (inputs.hyprland-plugins.packages.${pkgs.system}.hyprbars.override {
      # Make sure it's using the same hyprland package as we are
      hyprland = config.wayland.windowManager.hyprland.package;
    }).overrideAttrs (old: {
      # Yeet the initialization notification (I hate it)
      postPatch = (old.postPatch or "") + ''
        ${lib.getExe pkgs.gnused} -i '/Initialized successfully/d' main.cpp
      '';
    });
in {
  options = { hyprland.enable = lib.mkEnableOption "Enables hyprland"; };
  config = lib.mkIf config.hyprland.enable {
    programs.hyprland = {
      enable = true;
      package = hyprland;
    };
    environment.systemPackages = [ pkgs.wlrctl ];
  };
}
