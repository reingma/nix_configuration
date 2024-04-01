{lib, config, ...}:
{
	options = {
		network-module.enable = lib.mkEnableOption "enables network control for the system";
	};
	config = lib.mkIf config.network-module.enable {
  		networking.networkmanager.enable = true;
		users.groups.network = {};
	};
}
