{ pkgs, config, lib, ... }: {
  options = { gh.enable = lib.mkEnableOption "enables gh"; };
  config = lib.mkIf config.gh.enable {
    programs.gh = {
      enable = true;
      extensions = with pkgs; [ gh-markdown-preview ];
      settings = {
        version = "1";
        git_protocol = "ssh";
        prompt = "enabled";
      };
    };
  };
}
