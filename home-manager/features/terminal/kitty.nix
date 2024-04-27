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
      shellIntegration.enableZshIntegration = true;
      settings = {
        scrollback_lines = 4000;
        scrollback_pager_history_size = 2048;
        window_padding_width = 15;
        foreground = "#${palette.base05}";
        background = "#${palette.base00}";
        selection_background = "#${palette.base05}";
        selection_foreground = "#${palette.base00}";
        #url_color = "${colors.on_surface_variant}";
        cursor = "#${palette.base05}";
        #active_border_color = "${colors.surface}";
        #inactive_border_color = "${colors.surface_bright}";
        active_tab_background = "#${palette.base00}";
        active_tab_foreground = "#${palette.base05}";
        #inactive_tab_background = "${colors.surface_bright}";
        #inactive_tab_foreground = "${colors.on_surface_variant}";
        #tab_bar_background = "${colors.surface_bright}";
        color0 = "#${palette.base00}";
        color1 = "#${palette.base08}";
        color2 = "#${palette.base0B}";
        color3 = "#${palette.base0A}";
        color4 = "#${palette.base0D}";
        color5 = "#${palette.base0E}";
        #color6 = "${colors.cyan}";
        color7 = "#${palette.base05}";
        color8 = "#${palette.base00}";
        #color15 = "${colors.surface_dim}";
        #color17 = "${colors.error}";
        #color18 = "${colors.surface_bright}";
        #color19 = "${colors.surface_container}";
        #color20 = "${colors.on_surface_variant}";
        #color21 = "${colors.inverse_surface}";
        background_opacity = "0.95";
      };
    };
  };
}
