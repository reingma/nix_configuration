{ config, pkgs, lib, ... }: {
  options = { spotify.enable = lib.mkEnableOption "enable spotify"; };
  config = lib.mkIf config.spotify.enable { home.packages = [ pkgs.spotify ]; };
}
