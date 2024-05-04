{ inputs, outputs, lib, config, pkgs, ... }:
let inherit (inputs.nix-colors) colorSchemes;
in {
  imports = [ inputs.nix-colors.homeManagerModules.default ./features ] ++ (builtins.attrValues outputs.homeManagerModules);
  config = {
    colorScheme = lib.mkDefault colorSchemes.tokyo-night-dark;
    wallpaper = lib.mkDefault pkgs.wallpapers.space;

    nixpkgs = {
      overlays = [
        outputs.overlays.additions
        outputs.overlays.modifications
        outputs.overlays.unstable-packages
        inputs.nur.overlay
      ];
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
        workspace = "1";
      }
      {
        name = "DP-4";
        width = 4096;
        height = 2160;
        x = -2560;
        workspace = "2";
      }
    ];
  };
}
