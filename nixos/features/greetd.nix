{ inputs, pkgs, lib, config, ... }:
let
  tuigreet = "${pkgs.greetd.tuigreet}/bin/tuigreet";
  hyprland-session = "${
      inputs.hyprland.packages.${pkgs.system}.hyprland
    }/share/wayland-sessions";
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
    environment.etc."greetd/environments".text = ''
      Hyprland
      bash
      zsh
    '';
    users.extraUsers.greeter = {
      home = "/tmp/greeter-home";
      createHome = true;
    };
    systemd.services.greetd.serviceConfig = {
      Type = "idle";
      StandardInput = "tty";
      StandardOutput = "tty";
      StandardError = "journal"; # Without this errors will spam on screen
      # Without these bootlogs will spam on screen
      TTYReset = true;
      TTYVHangup = true;
      TTYVTDisallocate = true;
    };

    #programs.regreet = {
    #  enable = true;
    #  settings = {
    #    GTK = {
    #      icon_theme_name = "Papirus";
    #      theme_name = "Nordic";
    #    };
    #    background = {
    #      path = wallpaper;
    #      fit = "Cover";
    #    };
    #  };
    #};
    services.greetd = {
      enable = true;
      settings = {
        default_session = {
          command =
            "${tuigreet} --time --remember --remember-session --sessions ${hyprland-session}";
          user = "greeter";
        };
      };
    };
  };
  # this is a life saver.
  # literally no documentation about this anywhere.
  # might be good to write about this...
  # https://www.reddit.com/r/NixOS/comments/u0cdpi/tuigreet_with_xmonad_how/
}
