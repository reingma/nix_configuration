{ lib, pkgs, config, ... }: {
  imports = [ ./discord.nix ./slack.nix ];
  home.packages = with pkgs; [ xdragon pavucontrol sublime-music playerctl ];
}
