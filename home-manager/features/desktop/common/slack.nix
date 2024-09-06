{
  config,
  pkgs,
  lib,
  ...
}:
{
  options = {
    slack.enable = lib.mkEnableOption "enable slack";
  };
  config = lib.mkIf config.slack.enable {
    xdg.mimeApps.defaultApplications = {
      "x-scheme-handler/slack" = "slack.desktop";
    };
    home.packages = [ pkgs.slack ];
  };
}
