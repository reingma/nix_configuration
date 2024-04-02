{config, lib, ...}: 
{
	options = {
		cli-tools.enable = lib.mkEnableOption "enables common cli tools";
	};
	imports = [
		./git.nix
		./bat.nix
		./direnv.nix
		./fzf.nix
		./gh.nix
		./ranger.nix
		./pfetch.nix
	];
	config = lib.mkIf config.cli-tools.enable {
		git.enable = lib.mkDefault true;
		bat.enable = lib.mkDefault true;
		direnv.enable = lib.mkDefault true;
		fzf.enable = lib.mkDefault true;
		gh.enable = lib.mkDefault true;
		ranger.enable = lib.mkDefault true;
		pfetch.enable = lib.mkDefault true;
		
		home.packages = with pkgs; [
			#font
			nerdfonts
			#utils
			neofetch 
		};
	};
}
