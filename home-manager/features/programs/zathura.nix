{ config, lib, pkgs, ... }: {
  programs.zathura = {
    enable = true;
    options = {
      default-bg = "#${config.colorScheme.palette.base00}";
      default-fg = "#${config.colorScheme.palette.base05}";
      selection-clipboard = "clipboard";
      font = "${config.fontProfiles.regular.family} 12";
    };
  };
}
