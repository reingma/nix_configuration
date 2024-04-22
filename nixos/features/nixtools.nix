{ lib, config, ... }: {
  options = { nixtools.enable = lib.mkEnableOption "enables nixtools"; };
  config = lib.mkIf config.nixtools.enable {
    programs.nh = { enable = true; };
  };
