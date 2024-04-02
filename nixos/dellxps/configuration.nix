{ inputs, outputs, lib, config, pkgs, ... }:

{
  imports = [ # Include the results of the hardware scan.
    ./hardware-configuration.nix
    ../features
    inputs.nixos-hardware.nixosModules.dell-xps-13-9310
    inputs.home-manager.nixosModules.home-manager
  ];
  nixpkgs = {
    overlays = [
      outputs.overlays.additions
      outputs.overlays.modifications
      outputs.overlays.unstable-packages
    ];
    config = { allowUnfree = true; };
  };

  home-manager = {
    extraSpecialArgs = { inherit inputs outputs; };
    users = { reingma = import ../../home-manager/dell_xps_home.nix; };
  };

  bluetooth.enable = lib.mkForce true;
  postgres.enable = lib.mkForce true;
  no-suspend.enable = lib.mkForce true;
  xfce.enable = lib.mkForce true;

  environment.etc = lib.mapAttrs' (name: value: {
    name = "nix/path/${name}";
    value.source = value.flake;
  }) config.nix.registry;

  networking.hostName = "polaris"; # Define your hostname.

  system.stateVersion = "23.11"; # Did you read the comment?
}
