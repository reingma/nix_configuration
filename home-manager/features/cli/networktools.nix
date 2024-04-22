{ config, pkgs, lib, ... }: {
  options = {
    networktools.enable = lib.mkEnableOption "enables network tools";
  };
  config = lib.mkIf config.networktools.enable {
    home.packages = with pkgs; [
      iperf3 # for network measurements
      aria2 # download tool for any type of protocol
      nmap # netowrk discovery and security
      iftop # network monitoring
      ethtool # checking on network devices
    ];
  };
}
