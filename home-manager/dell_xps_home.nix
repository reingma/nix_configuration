{ inputs, outputs, lib, config, pkgs, ...}: let
	inherit (inputs.nix-colors) colorSchemes;
in {
	imports = [
		inputs.nix-colors.homeManagerModules.default
		./terminal
		./programs
		./features/cli
	];
	colorScheme = lib.mkDefault colorSchemes.rose-pine-moon;

	nixpkgs = {
		overlays = [
			outputs.overlays.additions
			outputs.overlays.modifications
			outputs.overlays.unstable-packages
			inputs.nur.overlay
		];
		config = {
			allowUnfree = true;
			allowUnfreePredicate = _: true;
		};
	};
	home = {
		username = lib.mkDefault "reingma";
		homeDirectory = lib.mkDefault "/home/reingma";
	};
	
	fonts.fontconfig.enable = true;
	xresources.properties = {
		"Xft.dpi" = 200;
	};
	
	
	home.stateVersion = "23.11";
	systemd.user.startServices = "sd-switch";
	programs.home-manager.enable = true;
}
