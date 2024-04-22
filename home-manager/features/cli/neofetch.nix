{ pkgs, config, lib, ... }: {
  options = { noefetch.enable = lib.mkEnableOption "enables pfetch"; };
  config = lib.mkIf config.neofetch.enable {
    home = { packages = with pkgs; [ neofetch ]; };
  };
}
