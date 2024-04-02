{config, lib, ...}:
{
	options = {
		fzf.enable = lib.mkEnableOption "enables fzf";
	};
	config = lib.mkIf config.fzf.enable {
		programs.fzf = {
			enable = true;
			defaultOptions = [ "--color 16" ];
			enableZshIntegration = true;
		};
	};
}
