{ lib, config, pkgs, ... }: 
let
	inherit (lib) mkIf;
	packageNames = map (p: p.pname or p.name or null) config.home.packages;
	hasPackage = name: lib.any (x: x == name ) packageNames;
	hasEza = hasPackage "eza";
	hasZoxide = config.programs.zoxide.enable;
	hasKitty = config.programs.kitty.enable;
in {
  options = { zsh.enable = lib.mkEnableOption "enables zsh shell"; };
  config = lib.mkIf config.zsh.enable {
    programs.zsh = {
      enable = true;
      initExtra = "	[[ ! -f ${./p10k.zsh} ]] || source ${./p10k.zsh}\n";
      zplug = {
        enable = true;
        plugins = [{
          name = "romkatv/powerlevel10k";
          tags = [ "as:theme" "depth:1" ];
        }];
      };
      shellAliases = rec {
	jqless = "jq -C | less -r";
        ls = mkIf hasEza "eza";
        cd = mkIf hasZoxide "z";
      };
      oh-my-zsh = {
        enable = true;
        plugins = [ "git" ];
      };
    };
    programs.bash = { enable = true; };
  };
}
