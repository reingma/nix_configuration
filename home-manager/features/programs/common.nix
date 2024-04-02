{ config, lib, pkgs, ... }: {

  programs.zoxide = {
    enable = true;
    enableZshIntegration = true;
  };
  programs.zathura = {
    enable = true;
    options = {
      default-bg = "#${config.colorScheme.palette.base00}";
      default-fg = "#${config.colorScheme.palette.base05}";
    };
  };
}
