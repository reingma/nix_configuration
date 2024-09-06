{
  config,
  pkgs,
  lib,
  ...
}:
{
  options = {
    monitoring.enable = lib.mkEnableOption "enables monitoring tools";
  };
  config = lib.mkIf config.monitoring.enable {
    home.packages = with pkgs; [
      btop # process monitoring
      iotop # io monitoring
      sysstat # monitoring system performance
      pciutils # checking on pci devices
      usbutils # lsusb for checking usb devices
    ];
  };
}
