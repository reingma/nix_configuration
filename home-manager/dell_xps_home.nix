{ inputs, outputs, lib, config, pkgs, ... }:
let inherit (inputs.nix-colors) colorSchemes;
in {
  options = {
    wallpaper = lib.mkOption {
      type = lib.types.nullOr lib.types.path;
      default = null;
      description = "Wallpaper path ";
    };
  };
  imports = [ inputs.nix-colors.homeManagerModules.default ./features ];
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
    home = {
      username = lib.mkDefault "reingma";
      homeDirectory = lib.mkDefault "/home/reingma";
    };

    fonts.fontconfig.enable = true;
    xresources.properties = lib.mkDefault { "Xft.dpi" = 200; };

    home.stateVersion = "23.11";
    systemd.user.startServices = "sd-switch";
    programs.home-manager.enable = true;
  };
}
