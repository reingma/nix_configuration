{lib, config, ...}:
{
	options = {
		network-module.enable = lib.mkEnableOption "enables network control for the system";
	};
	config = lib.mkIf config.network-module.enable {
  		networking.networkmanager.enable = true;
		networking.wireless = {
			enable = true;
			userControlled = {
				enable = true;
				group = "network";
			};	
		users.groups.network = {};
	};
}
