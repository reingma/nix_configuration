{ lib, config, pkgs, ... }: {
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
      shellAliases = {
        ls = "eza";
        cd = "z";
      };
      oh-my-zsh = {
        enable = true;
        plugins = [ "git" ];
      };
    };
    programs.bash = { enable = true; };
  };
}
