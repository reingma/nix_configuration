{ pkgs, lib, config, ...}:
{
	imports = [
		./users
		./locale.nix
		./nix.nix
		./docker.nix
		./pipewire.nix
		./zsh.nix
		./bluetooth.nix
	];
	docker.enable = lib.mkDefault true;
	pipewire-sound.enable = lib.mkDefault true;
	zsh-shell.enable = lib.mkDefault true;
	bluetooth.enable = lib.,mkDefault false;
}
