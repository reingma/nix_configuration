{config, lib, ...}: 
{
	options = {
		cli-tools.enable = lib.mkEnableOption "enables common cli tools";
	};
	imports = [
		./git.nix
		./bat.nix
		./direnv.nix
	];
	config = lib.mkIf config.cli-tools.enable {
		git.enable = lib.mkDefault true;
		bat.enable = lib.mkDefault true;
		direnv.enable = lib.mkDefault true;
	};
}
