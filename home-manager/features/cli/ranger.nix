{ pkgs, config, lib, ... }: {
  options = { ranger.enable = lib.mkEnableOption "enables ranger"; };
  config =
    lib.mkIf config.ranger.enable { home.packages = with pkgs; [ ranger ]; };
}
