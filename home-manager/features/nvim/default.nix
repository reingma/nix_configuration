{ config, pkgs, lib, ... }: {
  options = { nvim.enable = lib.mkEnableOption "enables neovim"; };
  config = lib.mkIf config.nvim.enable {
    home.sessionVariables.EDITOR = "nvim";
    programs.neovim = {
      enable = true;
      viAlias = true;
      vimAlias = true;
      vimdiffAlias = true;
      extraLuaConfig = ''
        ${builtins.readFile ./nvim_config/init.lua}
      '';
    };
  };
}
