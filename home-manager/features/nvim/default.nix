{ config, pkgs, lib, ... }: {
  options = { nvim.enable = lib.mkEnableOption "enables neovim"; };
  config = lib.mkIf config.nvim.enable {
    home.sessionVariables.EDITOR = "nvim";
    programs.neovim = {
      enable = true;
      viAlias = true;
      vimAlias = true;
      vimdiffAlias = true;

      extraPackages = with pkgs; [
        lua-language-server
        stylua
        nixfmt
        nil
        gopls
        marksman
      ];
    };
    home.file."./.config/nvim/" = {
      source = ./nvim_config;
      recursive = true;
    };
    xdg.desktopEntries = {
      nvim = {
        name = "Neovim";
        genericName = "Text Editor";
        comment = "Edit text files";
        exec = "nvim %F";
        icon = "nvim";
        mimeType = [
          "text/english"
          "text/plain"
          "text/x-makefile"
          "text/x-c++hdr"
          "text/x-c++src"
          "text/x-chdr"
          "text/x-csrc"
          "text/java"
          "text/x-tex"
          "text/x-c"
          "text/x-c++"
          "text/x-shellscript"
        ];
        terminal = true;
        type = "Application";
        categories = [ "Utility" "TextEditor" ];
      };
    };
  };
}
