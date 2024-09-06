{
  config,
  pkgs,
  lib,
  ...
}:
{
  options = {
    nixtools.enable = lib.mkEnableOption "enables nixtools";
  };
  config = lib.mkIf config.nixtools.enable {
    home.packages = with pkgs; [
      nixd
      nil
      nixfmt-rfc-style
      nvd
      nix-output-monitor
    ];
  };
}
