{
  description = "NixOs Configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-23.11";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager/release-23.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hyprland-plugins = {
      url = "github:hyprwm/hyprland-plugins/e9457e08ca3ff16dc5a815be62baf9e18b539197";
    };
    nixos-hardware.url = "github:NixOs/nixos-hardware/master";
    nix-colors.url = "github:misterio77/nix-colors";
    nur.url = "github:nix-community/NUR";
  };

  outputs = { self, nixpkgs, home-manager, nur, ... }@inputs:
    let
      inherit (self) outputs;
      systems = [ "aarch64-linux" "x86_64-linux" ];
      lib = nixpkgs.lib // home-manager.lib;
      pkgsFor = lib.genAttrs systems (system:
        import nixpkgs {
          inherit system;
          config.allowUnfree = true;
        });
      forEachSystem = f: lib.genAttrs systems (system: f pkgsFor.${system});
    in {
      inherit lib;
      homeManagerModules = import ./modules/home-manager;
      nixosModules = import ./modules/nixos;

      overlays = import ./overlays { inherit inputs outputs; };


      packages = forEachSystem (pkgs: import ./pkgs { inherit pkgs; });
      devShells = forEachSystem (pkgs: import ./shell.nix { inherit pkgs; });
      formatter = forEachSystem (pkgs: pkgs.nixpkgs-fmt);

      nixosConfigurations.polaris = lib.nixosSystem {
        specialArgs = { inherit inputs outputs; };
        modules = [ ./nixos/polaris];
      };

#      if we want to use separate builds, home and system.
#      homeConfigurations = {
#        "reingma@polaris" = lib.homeManagerConfiguration {
#          modules = [ ./home-manager/polaris.nix ];
#          pkgs = pkgsFor.x86_64-linux;
#          extraSpecialArgs = {
#            inherit inputs outputs;
#          };
#        };
#      };

    };
}
