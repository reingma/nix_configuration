{ config, lib, ... }: {
  options = { xfce.enable = lib.mkEnableOption "enables xfce desktop"; };
  config = lib.mkIf config.xfce.enable {
    services.xserver = {
      displayManager = {
        lightdm.enable = true;
        autoLogin = {
          enable = true;
          user = "reingma";
        };
      };
      desktopManager = { xfce.enable = true; };
    };
  };
}
