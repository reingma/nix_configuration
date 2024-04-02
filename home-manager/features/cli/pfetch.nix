{config, lib, ...}:
{
	options = {
		pfetch.enable = lib.mkEnableOption "enables pfetch";
	};
	config = lib.mkIf config.pfetch.enable {
		home = {
			packages = with pkgs; [ pfetch ];
			sessionVariables.PF_INFO = "ascii title os kernel uptime shell term desktop scheme palette";
		};
	};
}
