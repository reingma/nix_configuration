{ pkgs, lib, config, ...}:
{
	imports = [
		./users
		./locale.nix
		./nix.nix
		./docker.nix
	];
	docker.enable = lib.mkDefault true;
}
