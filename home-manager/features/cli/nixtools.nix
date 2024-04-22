{ config, lib, ... }: {
  options = { nixtools.enable = lib.mkEnableOption "enables nixtools"; };
  config = lib.mkIf config.nixtools.enable {
    programs.nh = {
      enable = true;
      clean.enable = true;
      clean.extraArgs = "--keep-since 4d --keep 3";
      flake = "/home/reingma/.sys_config";
    };
    programs.nil = { enable = true; };
    programs.nixfmt = { enable = true; };
    programs.nvd = { enable = true; };
    nix-output-monitor = { eanble = true; };
  };
}
