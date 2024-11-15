{
  config,
  pkgs,
  lib,
  ...
}:
{
  options = {
    nvim.enable = lib.mkEnableOption "enables neovim";
  };
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
        nixfmt-rfc-style
        nil
        marksman
        nodePackages.vscode-langservers-extracted
        nodePackages.yaml-language-server
        nodePackages.dockerfile-language-server-nodejs
        nodePackages.typescript-language-server
        emmet-ls
        nodePackages."@tailwindcss/language-server"
        rust-analyzer
        nodePackages.prettier
        metals
        texlab
        haskell-language-server
        gopls
        hadolint
        nodePackages.jsonlint
        markdownlint-cli2
        vscode-extensions.vadimcn.vscode-lldb
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
        categories = [
          "Utility"
          "TextEditor"
        ];
      };
    };
  };
}
