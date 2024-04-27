{ pkgs, lib, config, ... }:
let
  homeCfgs = config.home-manager.users;
  homeSharePaths = lib.mapAttrsToList (_: v: "${v.home.path}/share") homeCfgs;
  vars = ''
    XDG_DATA_DIRS="$XDG_DATA_DIRS:${
      lib.concatStringsSep ":" homeSharePaths
    }" GTK_USE_PORTAL=0'';

  wallpaper = homeCfgs.reingma.wallpaper;
  sway-kiosk = command: "${lib.getExe pkgs.sway} --unsupported-gpu --config ${pkgs.writeText "kiosk.config" ''
    output * bg #000000 solid_color
    xwayland disable
    input "type:touchpad" {
      tap enabled
    }
    exec '${vars} ${command}; ${pkgs.sway}/bin/swaymsg exit'
  ''}";
in {
  options = { greetd.enable = lib.mkEnableOption "enables greetd"; };
  config = lib.mkIf config.greetd.enable {
    users.extraUsers.greeter = {
      home = "/tmp/greeter-home";
      createHome = true;
    };

    programs.regreet = {
      enable = true;
      settings = {
        GTK = {
          icon_theme_name = "Papirus";
          theme_name = "Nordic";
        };
      };
    };
    services.greetd = { 
      enable = true;
      settings.default_session.command = sway-kiosk (lib.getExe config.programs.regreet.package);
    };
  };
}

