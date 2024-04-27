{ pkgs, lib, config, ... }:
let
  homeCfgs = config.home-manager.users;
  homeSharePaths = lib.mapAttrsToList (_: v: "${v.home.path}/share") homeCfgs;
  vars = ''
    XDG_DATA_DIRS="$XDG_DATA_DIRS:${
      lib.concatStringsSep ":" homeSharePaths
    }" GTK_USE_PORTAL=0'';

  wallpaper = homeCfgs.reingma.wallpaper;
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
          theme_name = gtkTheme.name;
        };
      };
    };
    services.greetd = { enable = true; };
  };
}

