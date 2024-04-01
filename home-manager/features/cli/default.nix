{config, lib, ...}: 
{
	options = {
		cli-tools.enable = lib.mkEnableOption "enables common cli tools";
	};
	imports = [
		./git.nix
	];
	config = lib.mkIf config.cli-tools.enable {
		git.enable = lib.mkDefault true;
	};
}
