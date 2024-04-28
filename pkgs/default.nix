{pkgs ? import <nixpkgs> {}}: let
  inherit (pkgs) lib;
in rec {
  wallpapers = import ./wallpapers {inherit pkgs;};
}
