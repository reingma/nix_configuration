{config, lib, ...}:
{
	options = {
		direnv.enable = lib.mkEnableOption "enables bat";
	};
	config = lib.mkIf config.direnv.enable {
		programs.direnv = {
			enable = true;
			nix-direnv.enable = true;
		};
	};
}
