{lib, config, ...}:
{
	options = {
		zsh-shell.enable = lib.mkEnableOption "enables the zsh shell";
	}
	
	config = lib.mkIf config.zsh-shell.enable {
		programs.zsh = {
			enable = true;
		};
	};
}
