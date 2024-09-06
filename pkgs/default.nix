{
  pkgs ? import <nixpkgs> { },
  ...
}:
let
  inherit (pkgs) lib;
in
rec {
  wallpapers = import ./wallpapers { inherit pkgs; };
  zsession = pkgs.callPackage ./zellij-sessionizer { };
  tsession = pkgs.callPackage ./tmux-sessionizer { };
}
