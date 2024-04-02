{ config, lib, ... }: {
  options = { x-server.enable = lib.mkEnableOption "enables xserver"; };
  config = lib.mkIf config.x-server.enable {
    services.xserver = {
      enable = true;
      layout = "us";
      xkbVariant = "";
    };
  };
}
