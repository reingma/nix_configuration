{config, lib, ...}:
{
	options = {
		bat.enable = lib.mkEnableOption "enables bat";
	};
	config = lib.mkIf config.bat.enable {
		programs.bat = {
			enable = true;
			config.theme = "base16";
		};
	};
}
