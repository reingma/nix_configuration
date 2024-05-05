{ pkgs, config, lib, ... }: {
  options = {
    cli-tools.enable = lib.mkEnableOption "enables common cli tools";
  };
  imports = [
    ./git.nix
    ./bat.nix
    ./direnv.nix
    ./fzf.nix
    ./gh.nix
    ./ranger.nix
    ./zoxide.nix
    ./nixtools.nix
    ./neofetch.nix
    ./monitoring.nix
    ./networktools.nix
  ];
  config = lib.mkIf config.cli-tools.enable {
    git.enable = lib.mkDefault true;
    bat.enable = lib.mkDefault true;
    direnv.enable = lib.mkDefault true;
    fzf.enable = lib.mkDefault true;
    gh.enable = lib.mkDefault true;
    ranger.enable = lib.mkDefault true;
    zoxide.enable = lib.mkDefault true;
    nixtools.enable = lib.mkDefault true;
    neofetch.enable = lib.mkDefault true;
    networktools.enable = lib.mkDefault true;
    monitoring.enable = lib.mkDefault true;

    home.packages = with pkgs; [

      # archives
      zip
      unzip
      p7zip
      gnutar # for tar compressing
      zstd # compression tool

      #utility
      ripgrep # super grep
      jq # utility for json parsing and prettify
      yq-go # similar to jq but for yaml
      btop # htop replacement
      eza # ls replacement
      bottom # system viewer
      bc # calculator
      fd # better find
      httpie # better curl
      diffsitter # better diff
      xclip # copy files to clipboard

      glow # markdown viwer on terminal
      ltex-ls # spell checker lsp

      #ssh
      openssh

      #minsc
      tree # list directory tree structure
      which # gives the path to executables
      file # gives file information
      gnused # for interacting with text using vi syntax
      gnupg # cryptography lib
      gawk # interacting with text files
    ];
  };
}
