{ config, ... }:
let
  inherit (config.colorScheme) palette;
in
{
  services.mako = {
    enable = true;
    padding = "10,20";
    anchor = "top-center";
    width = 400;
    height = 100;
    borderSize = 2;
    defaultTimeout = 12000;
    backgroundColor = "#${palette.base00}dd";
    borderColor = "#${palette.base05}dd";
    textColor = "#${palette.base08}dd";
    layer = "overlay";
  };
}
