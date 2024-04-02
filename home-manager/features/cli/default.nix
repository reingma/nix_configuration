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
    ./pfetch.nix
    ./zoxide.nix
  ];
  config = lib.mkIf config.cli-tools.enable {
    git.enable = lib.mkDefault true;
    bat.enable = lib.mkDefault true;
    direnv.enable = lib.mkDefault true;
    fzf.enable = lib.mkDefault true;
    gh.enable = lib.mkDefault true;
    ranger.enable = lib.mkDefault true;
    pfetch.enable = lib.mkDefault true;
    zoxide.enable = lib.mkDefault true;

    home.packages = with pkgs; [
      #font
      nerdfonts

      #utils
      neofetch # info fetching

      # archives
      zip
      unzip
      p7zip

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

      #nix tooling
      nil # lsp
      nixfmt # formatter
      nvd # differ
      nix-output-monitor # for monitoring a build

      ltex-ls # spell checker lsp

      # markdown viewer on terminal
      glow

      # monitoring
      btop # process monitoring
      iotop # io monitoring
      iftop # network monitoring

      #network
      iperf3 # for network measurements
      aria2 # download tool for any type of protocol
      nmap # netowrk discovery and security

      #sys tools
      sysstat # monitoring system performance
      ethtool # checking on network devices
      pciutils # checking on pci devices
      usbutils # lsusb for checking usb devices

      #ssh
      openssh
      xclip

      #minsc
      tree # list directory tree structure
      which # gives the path to executables
      file # gives file information
      gnutar # for tar compressing
      gnused # for interacting with text using vi syntax
      zstd # compression tool
      gnupg # cryptography lib
      gawk # interacting with text files
    ];
  };
}
