{ pkgs ? import <nixpkgs> { }, ... }: {
  default = pkgs.mkShell {
    NIX_CONFIG = "extra-experimental-features = nix-command flakes repl-flake ca-derivations";
    nativeBuildinputs = with pkgs; [nix home-manager git gnupg];
    packages = with pkgs; [ zig nix home-manager git ];
  };
}
