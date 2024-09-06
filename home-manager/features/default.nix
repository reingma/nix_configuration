{ lib, config, ... }:
{
  imports = [
    ./cli
    ./terminal
    ./nvim
    ./desktop
  ];
  terminal.enable = lib.mkDefault true;
  cli-tools.enable = lib.mkDefault true;
  nvim.enable = lib.mkDefault true;
  desktop.enable = lib.mkDefault true;
}
