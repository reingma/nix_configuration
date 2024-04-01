{lib, config, ...}: 
{
	options = {
		terminal.enable = lib.mkEnableOption "enables custom terminal";
	};
	imports = [
		./kitty.nix
		./shell
	];
	config = lib.mkIf config.terminal.enable {
		kitty.enable = lib.mkDefault true;
		zsh.enable = lib.mkDefault true;
	};
}
