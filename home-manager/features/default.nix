{lib, config, ...}: 
{
	imports = [
		./cli
		./terminal
		./programs
	];
	terminal.enable = lib.mkDefault true;
	cli-tools.enable = lib.mkDefault true;
}
