{ config, lib, pkgs, ... }: {
  options = { kitty.enable = lib.mkEnableOption "enable kitty terminal"; };
  config = lib.mkIf config.kitty.enable {
    programs.kitty = {
      enable = true;
      shellIntegration.enableZshIntegration = true;
      settings = {
        foreground = "#${config.colorScheme.palette.base05}";
        background = "#${config.colorScheme.palette.base00}";
        background_opacity = "0.95";
      };
    };
  };
}
