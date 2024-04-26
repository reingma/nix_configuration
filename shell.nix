{ pkgs ? import <nixpkgs> {}}: {
default = pkgs.mkShell {
  packages = [pkgs.zig];
};
}
