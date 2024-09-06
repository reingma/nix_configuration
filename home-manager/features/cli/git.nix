{
  pkgs,
  lib,
  config,
  ...
}:
{
  options = {
    git.enable = lib.mkEnableOption "enables git";
  };
  config = lib.mkIf config.git.enable {
    programs.git = {
      package = pkgs.gitAndTools.gitFull;
      enable = true;
      userName = "reingma";
      userEmail = "gabriel.masarin.aguiar@gmail.com";
      extraConfig = {
        init.defaultBranch = "main";
        merge.conflictStyle = "zdiff3";
        commit.verbose = true;
        diff.algorithm = "histogram";
      };
      ignores = [ "result" ];
    };
    programs.lazygit = {
      enable = true;
    };
  };
}
