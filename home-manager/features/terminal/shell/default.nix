{ config, pkgs, ...}:
{
	programs.zsh = {
		enable = true;
		initExtra = ''
			[[ ! -f ${./p10k.zsh} ]] || source ${./p10k.zsh}
		'';
		zplug = {
			enable = true;
			plugins = [
				{ name = "romkatv/powerlevel10k"; tags = [as:theme depth:1]; }
			];
		};
		shellAliases = {
			ls = "eza";
			cd = "z";
		};
		oh-my-zsh = {
			enable = true;
			plugins = [ "git" ];
		};
	};
	programs.bash = {
		enable = true;
	};
}
