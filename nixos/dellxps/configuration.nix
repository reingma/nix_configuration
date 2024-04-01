{ inputs, outputs, lib, config, pkgs, ... }:

{
  	imports = [ # Include the results of the hardware scan.
      		./hardware-configuration.nix
		inputs.nixos-hardware.nixosModules.dell-xps-13-9310
		inputs.home-manager.nixosModules.home-manager
		../features
  	];
	nixpkgs = {
		overlays = [
			outputs.overlays.additions
			outputs.overlays.modifications
			outputs.overlays.unstable-packages
		];
		config = {
			allowUnfree = true;
		};
	};


	home-manager = {
		extraSpecialArgs = { inherit inputs outputs; };
		users = {
			reingma = import ../../home-manager/dell_xps_home.nix;
		};
	};
	
	bluetooth.enable = lib.mkForce true;
	postgres.enable = lib.mkForce true;

	environment.etc =
		lib.mapAttrs'
		(name: value: {
			name = "nix/path/${name}";
			value.source = value.flake;
		})
		config.nix.registry;

  	# Bootloader.
  	boot.loader.systemd-boot.enable = true;
  	boot.loader.efi.canTouchEfiVariables = true;

  	networking.hostName = "polaris"; # Define your hostname.

  	# Enable the X11 windowing system.
  	services.xserver.enable = true;

  	# Enable the XFCE Desktop Environment.
  	services.xserver.displayManager.lightdm.enable = true;
  	services.xserver.desktopManager.xfce.enable = true;

  	# Configure keymap in X11
  	services.xserver = {
    		layout = "us";
    		xkbVariant = "";
  	};

  	# Enable CUPS to print documents.
  	services.printing.enable = true;

  	# Enable automatic login for the user.
  	services.xserver.displayManager.autoLogin.enable = true;
  	services.xserver.displayManager.autoLogin.user = "reingma";

  	# List packages installed in system profile. To search, run:
  	# $ nix search wget
  	environment.systemPackages = with pkgs; [
    		vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    		wget
    		git
    		curl
  	];
  	environment.variables.EDITOR = "vim";

  	system.stateVersion = "23.11"; # Did you read the comment?
}
