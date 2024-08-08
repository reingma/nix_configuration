{ inputs, outputs, lib, config, pkgs, ... }: {
  imports = [
    #./hardware-configuration.nix
    ../features
    inputs.home-manager.nixosModules.home-manager
  ];
  nixpkgs = {
    overlays = [
      outputs.overlays.additions
      outputs.overlays.modifications
      outputs.overlays.stable-packages
    ];
    config = { allowUnfree = true; };
  };

  home-manager = {
    extraSpecialArgs = { inherit inputs outputs; };
    users = { reingma = import ../../home-manager/wsl.nix; };
  };

  xdg.portal = {
    enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-hyprland ];
    config.common.default = "*";
  };

  bluetooth.enable = lib.mkForce true;
  environment.systemPackages =
    [ pkgs.zsession pkgs.tsession pkgs.zig pkgs.clang ];

  environment.etc = lib.mapAttrs' (name: value: {
    name = "nix/path/${name}";
    value.source = value.flake;
  }) config.nix.registry;

  networking.hostName = "wsl"; # Define your hostname.

  system.stateVersion = "23.11"; # Did you read the comment?
}
