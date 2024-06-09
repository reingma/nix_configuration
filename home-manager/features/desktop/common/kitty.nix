{ config, lib, pkgs, ... }:
let inherit (config.colorScheme) palette;
in {
  options = { kitty.enable = lib.mkEnableOption "enable kitty terminal"; };
  config = lib.mkIf config.kitty.enable {
    xdg.mimeApps = {
      associations.added = { "x-scheme-handler/terminal" = "kitty.desktop"; };
      defaultApplications = { "x-scheme-handler/terminal" = "kitty.desktop"; };
    };
    programs.kitty = {
      enable = true;
      font = {
        name = config.fontProfiles.monospace.family;
        size = 12;
      };
      keybindings = { "ctrl+shift+j" = "new_window_with_cwd"; };
      shellIntegration.enableZshIntegration = true;
      settings = {
        scrollback_lines = 4000;
        scrollback_pager_history_size = 2048;
        window_padding_width = 15;
        foreground = "#${palette.base05}";
        background = "#${palette.base00}";
        selection_background = "#${palette.base05}";
        selection_foreground = "#${palette.base00}";
        cursor = "#${palette.base05}";
        active_tab_background = "#${palette.base00}";
        active_tab_foreground = "#${palette.base05}";
        color0 = "#${palette.base00}";
        color1 = "#${palette.base0F}"; # red
        color2 = "#${palette.base0B}"; # green
        color3 = "#${palette.base0A}"; # yellow
        color4 = "#${palette.base0A}"; # blue
        color5 = "#${palette.base0E}"; # magenta
        color7 = "#${palette.base05}";
        color8 = "#${palette.base00}";
        background_opacity = "0.95";
      };
    };
  };
}
