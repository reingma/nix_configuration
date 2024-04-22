{ config, pkgs, ... }: {
  options = { nvim.enable = lib.mkEnableOption "enables neovim"; };
  config = lib.mkIf config.nvim.enable {
    home.sessionVariables.EDITOR = "nvim";
    programs.neovim = { enable = true; };
  };
}
