{lib, config, ...}:
{
	options = {
		no-suspend.enable = lib.mkEnableOption "enable does not suspend";
	};
	config = lib.mkIf config.no-suspend.enable {
		services.xserver.serverFlagsSection = ''
			Option "StandbyTime" "0"
			Option "SuspendTime" "0"
			Option "OffTime" "0"
		'';
	};
}	
