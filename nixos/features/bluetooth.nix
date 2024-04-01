{ lib, config, ...}:
{
	options = {
		bluetooth.enable = lib.mkEnableOption "enables docker";
	};
	config = lib.mkIf config.bluetooth.enable {
  		hardware.bluetooth.enable = true;
  		hardware.bluetooth.powerOnBoot = true;
  		services.blueman.enable = true;
	};
}
