# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

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
	users.users.reingma = {
		isNormalUser = true;
    		description = "Gabriel";
		shell = pkgs.zsh;
		extraGroups = [
			"wheel"
			"video"
			"audio"
		];
	};
	nix.registry = (lib.mapAttrs (_: flake: {inherit flake;})) ((lib.filterAttrs (_:lib.isType "flake")) inputs);
	nix.nixPath = ["/etc/nix/path"];
	environment.etc =
		lib.mapAttrs'
		(name: value: {
			name = "nix/path/${name}";
			value.source = value.flake;
		})
		config.nix.registry;
	nix.settings = {
		experimental-features = "nix-command flakes";
		auto-optimise-store = true;	
	};

  	# Bootloader.
  	boot.loader.systemd-boot.enable = true;
  	boot.loader.efi.canTouchEfiVariables = true;

  	networking.hostName = "polaris"; # Define your hostname.
  	# networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  	# Configure network proxy if necessary
  	# networking.proxy.default = "http://user:password@proxy:port/";
  	# networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  	# Enable networking
  	networking.networkmanager.enable = true;

  	# Set your time zone.
  	time.timeZone = "Europe/Copenhagen";

  	# Select internationalisation properties.
  	i18n.defaultLocale = "en_DK.UTF-8";

  	i18n.extraLocaleSettings = {
    		LC_ADDRESS = "da_DK.UTF-8";
    		LC_IDENTIFICATION = "da_DK.UTF-8";
    		LC_MEASUREMENT = "da_DK.UTF-8";
    		LC_MONETARY = "da_DK.UTF-8";
    		LC_NAME = "da_DK.UTF-8";
    		LC_NUMERIC = "da_DK.UTF-8";
    		LC_PAPER = "da_DK.UTF-8";
    		LC_TELEPHONE = "da_DK.UTF-8";
    		LC_TIME = "da_DK.UTF-8";
  	};

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

  	# Enable sound with pipewire.
  	sound.enable = true;
  	hardware.pulseaudio.enable = false;
  	security.rtkit.enable = true;
  	services.pipewire = {
    		enable = true;
    		alsa.enable = true;
    		alsa.support32Bit = true;
    		pulse.enable = true;
  	};

  	programs.zsh.enable = true;

  	# Enable automatic login for the user.
  	services.xserver.displayManager.autoLogin.enable = true;
  	services.xserver.displayManager.autoLogin.user = "reingma";

  	# Enable bluetooth control
  	hardware.bluetooth.enable = true;
  	hardware.bluetooth.powerOnBoot = true;
  	services.blueman.enable = true;

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
