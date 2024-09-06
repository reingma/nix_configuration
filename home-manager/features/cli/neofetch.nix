{
  pkgs,
  config,
  lib,
  ...
}:
{
  options = {
    neofetch.enable = lib.mkEnableOption "enables pfetch";
  };
  config = lib.mkIf config.neofetch.enable {
    home = {
      packages = with pkgs; [ neofetch ];
    };
  };
}
