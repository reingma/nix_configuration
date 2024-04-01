{
	description = "NixOs Configuration";

  	inputs = {
    		nixpkgs.url = "github:nixos/nixpkgs/nixos-23.11";
		nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    		home-manager = {
			url = "github:nix-community/home-manager/release-23.11";
			inputs.nixpkgs.follows = "nixpkgs";
   		};
		nixos-hardware.url = "github:NixOs/nixos-hardware/master";
		nix-colors.url = "github:misterio77/nix-colors";
		nur.url = "github:nix-community/NUR";
  	};

  	outputs = { self, nixpkgs, home-manager, nur , ... }@inputs: let 
		inherit (self) outputs;
		systems = [
			"aarch64-linux"
			"x86_64-linux"
		];
		lib = nixpkgs.lib // home-manager.lib;
		pkgsFor = lib.genAttrs systems (system: import nixpkgs {
			inherit system;
			config.allowUnfree = true;
		});
		forEachSystem = f: lib.genAttrs systems (system: f pkgsFor.${system});
		in {
			inherit lib;

			overlays = import ./overlays {inherit inputs outputs;};

			nixosModules = import ./modules/nixos;
			homeManagerModules = import ./modules/home-manager;
		
			packages = forEachSystem (pkgs: import ./pkgs { inherit pkgs; });

			formatter = forEachSystem (pkgs: pkgs.nixpkgs-fmt);	

			nixosConfigurations.polaris = nixpkgs.lib.nixosSystem {
				specialArgs = {inherit inputs outputs;};
				modules = [
					./nixos/dellxps/configuration.nix
				];
			};
		};
}
