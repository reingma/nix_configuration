{ pkgs, lib, config, ...}:
{
	imports = [
		./users
		./locale.nix
		./nix.nix
		./docker.nix
		./pipewire.nix
	];
	docker.enable = lib.mkDefault true;
	pipewire-sound.enable = lib.mkDefault true;
}
