{ pkgs, lib, config, ... }: {
  imports = [ ./reingma ];
  reingma.enable = lib.mkDefault true;
}
