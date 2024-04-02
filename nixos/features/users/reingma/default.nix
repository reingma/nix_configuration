{ lib, pkgs, config, ... }:
let
  ifExists = groups:
    builtins.filter (group: builtins.hasAttr group config.users.groups) groups;
in {
  options = { reingma.enable = lib.mkEnableOption "enables reingma user"; };
  config = lib.mkIf config.reingma.enable {

    users.users.reingma = {
      isNormalUser = true;
      description = "Gabriel";
      shell = pkgs.zsh;
      extraGroups = [ "wheel" "video" "audio" ] ++ ifExists [
        "network"
        "mysql"
        "docker"
        "git"
        "podman"
        "networkmanager"
      ];
    };
  };
}
