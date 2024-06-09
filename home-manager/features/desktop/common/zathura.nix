{ config, lib, pkgs, ... }: {
  options = { zathura.enable = lib.mkEnableOption "enable zathura reader"; };
  config = lib.mkIf config.zathura.enable {
    programs.zathura = {
      enable = true;
      options = {
        default-bg = "#${config.colorScheme.palette.base00}";
        default-fg = "#${config.colorScheme.palette.base05}";
        selection-clipboard = "clipboard";
        font = "${config.fontProfiles.regular.family} 12";
      };
    };
  };
}
