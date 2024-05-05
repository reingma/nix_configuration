{ config, pkgs, ... }: {
  xdg.mimeApps.defaultApplications = {
    "text/html" = [ "org.qutebrowser.qutebrowser.desktop" ];
    "text/xml" = [ "org.qutebrowser.qutebrowser.desktop" ];
    "x-scheme-handler/http" = [ "org.qutebrowser.qutebrowser.desktop" ];
    "x-scheme-handler/https" = [ "org.qutebrowser.qutebrowser.desktop" ];
    "x-scheme-handler/qute" = [ "org.qutebrowser.qutebrowser.desktop" ];
  };
  programs.qutebrowser = {
    enable = true;
    settings = {
      colors = {
        webpage.preferred_color_scheme = "${config.colorScheme.variant}";
        tabs.bar.bg = "#${config.colorScheme.palette.base00}";
        keyhint.fg = "#${config.colorScheme.palette.base05}";
      };
      fonts = {
        default_family = config.fontProfiles.regular.family;
        default_size = "12pt";
      };
      url = {
        default_page = "about:blank";
        start_pages = [ "https://www.google.com" ];
      };
    };
    searchEngines = { DEFAULT = "https://www.google.com/search?hl=en&q={}"; };
  };
  programs.firefox = {
    enable = true;
    profiles = {
      gabriel = {
        id = 0;
        extensions = with pkgs.nur.repos.rycee.firefox-addons; [
          ublock-origin
          vimium
        ];
      };
    };
  };
}
