{ config, lib, pkgs, ... }:
let inherit (config.colorScheme) palette;
in {
  options = { zellij.enable = lib.mkEnableOption "enable zelijj multiplexer"; };
  config =
    lib.mkIf config.zellij.enable { programs.zellij = { enable = true; }; };
}
