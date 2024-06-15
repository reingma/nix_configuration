{ config, lib, ... }: {
  options = {
    remap.enable = lib.mkEnableOption "enables remaping of capslock to escape";
  };
  config = lib.mkIf config.remap.enable {
    services.keyd = {
      enable = true;
      keyboards = {
        default = {
          ids = [ "*" ];
          settings = { main = { capslock = "overload(meta, esc)"; }; };
        };
      };
    };
  };
}
