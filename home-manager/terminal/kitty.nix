{ config, pkgs, ... }:
{
	programs.kitty = {
		enable = true;
		shellIntegration.enableZshIntegration = true;
		settings = {
			foreground = "#${config.colorScheme.palette.base05}";
			background = "#${config.colorScheme.palette.base00}";
			background_opacity = "0.95";
		};
	};
}
