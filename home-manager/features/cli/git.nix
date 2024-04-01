{ pkgs, libs, config, ... }:
{
	programs.git = {
		package = pkgs.gitAndTools.gitFull;
		enable = true;
		userName = "reingma";
		userEmail = "gabriel.masarin.aguiar@gmail.com";
		extraConfig = {
			init.defaultBranch = "master";
		};
		ignores = [ "result" ];
	};
	programs.lazygit = {
		enable = true;
	};
}
