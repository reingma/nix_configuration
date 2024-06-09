{ lib, pkgs, config, ... }: {
  imports = [
    ./discord.nix
    ./slack.nix
    ./browsers.nix
    ./kitty.nix
    ./xdg.nix
    ./spotify.nix
    ./zathura.nix
  ];
  config = {
    home.packages = with pkgs; [ xdragon pavucontrol sublime-music playerctl ];
    kitty.enable = lib.mkDefault true;
    xdgconfig.enable = lib.mkDefault true;
    zathura.enable = lib.mkDefault true;
    browsers.enable = lib.mkDefault true;
    discord.enable = lib.mkDefault true;
    slack.enable = lib.mkDefault true;
    spotify.enable = lib.mkDefault true;
  };
}
