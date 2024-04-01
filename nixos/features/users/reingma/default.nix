{ pkgs, config, ... }:
	let ifExists = groups: builtins.filter (group: builtins.hasAttr group config.users.groups) groups;
in  {
	users.users.reingma = {
		isNormalUser = true;
    		description = "Gabriel";
		shell = pkgs.zsh;
		extraGroups = [
			"wheel"
			"video"
			"audio"
		] ++ ifExists [
			"network"
			"mysql"
			"docker"
			"git"
			"podman"
			"networkmanager"
		];
	};
}
