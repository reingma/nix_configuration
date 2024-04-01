{ pkgs, lib, config, ...}:
{
	imports = [
		./users
		./locale.nix
		./nix.nix
	];
}
