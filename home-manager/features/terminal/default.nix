{config, ...}: let
	d = config.xdg.dataHome;
	c = config.xdg.configHome;
in {
	imports = [
		./kitty.nix
		./shell
	];
}
