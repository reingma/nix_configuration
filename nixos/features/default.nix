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
		./network.nix
		./postgres.nix
		./no-suspend.nix
		./systemd-boot.nix
		./xserver.nix
	];
	docker.enable = lib.mkDefault true;
	pipewire-sound.enable = lib.mkDefault true;
	zsh-shell.enable = lib.mkDefault true;
	network-module.enable = lib.mkDefault true;
	x-server.enable = lib.mkDefault true;

	bluetooth.enable = lib.mkDefault false;
	postgres.enable = lib.mkDefault false;
	no-suspend.enable = lib.mkDefault false;
}
