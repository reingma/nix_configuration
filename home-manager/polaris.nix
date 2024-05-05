{ inputs, outputs, lib, config, pkgs, ... }: {
  imports = [ inputs.nix-colors.homeManagerModules.default ./features ]
    ++ (builtins.attrValues outputs.homeManagerModules);

  config = {
    nix = {
      package = lib.mkDefault pkgs.nix;
      settings = {
        experimental-features = [
          "nix-command"
          "flakes"
          "repl-flake"
          #"ca-derivations"
        ];
        warn-dirty = false;
      };
    };
    colorScheme = lib.mkDefault inputs.nix-colors.colorSchemes.tokyo-night-dark;
    wallpaper = lib.mkDefault pkgs.wallpapers.space;
    fontProfiles = {
      enable = true;
      monospace = {
        family = "FiraCode Nerd Font";
        package = pkgs.nerdfonts.override {fonts = ["FiraCode"];};
      };
      regular = {
        family = "Fira Sans";
        package = pkgs.fira;
      };
    };




    nixpkgs = {
      overlays = builtins.attrValues outputs.overlays ++ [ inputs.nur.overlay ];

      config = {
        allowUnfree = true;
        allowUnfreePredicate = _: true;
      };
    };

    fonts.fontconfig.enable = true;
    xresources.properties = lib.mkDefault { "Xft.dpi" = 200; };

    home.stateVersion = "23.11";
    systemd.user.startServices = "sd-switch";
    programs.home-manager.enable = true;

    monitors = [
      {
        name = "eDP-1";
        width = 2560;
        height = 1600;
        primary = true;
        workspace = "6";
      }
      {
        name = "DP-4";
        width = 4096;
        height = 2160;
        x = -2560;
        workspace = "1";
      }
    ];
  };
}
