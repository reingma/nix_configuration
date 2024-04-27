{ pkgs, lib, config, ... }: {
  imports = [
    ./users
    ./locale.nix
    ./nix.nix
    ./docker.nix
    ./pipewire.nix
    ./zsh.nix
    ./bluetooth.nix
    ./network.nix
    ./postgres.nix
    ./systemd-boot.nix
    ./xserver.nix
    ./printing.nix
    ./greetd.nix
  ];
  docker.enable = lib.mkDefault true;
  pipewire-sound.enable = lib.mkDefault true;
  zsh-shell.enable = lib.mkDefault true;
  network-module.enable = lib.mkDefault true;
  x-server.enable = lib.mkDefault true;
  printing.enable = lib.mkDefault true;
  greetd.enable = lib.mkDefault true;

  bluetooth.enable = lib.mkDefault false;
  postgres.enable = lib.mkDefault false;

  environment.systemPackages = with pkgs; [ vim wget git curl ];
  environment.variables.EDITOR = "vim";
}
