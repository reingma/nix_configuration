
{ lib, config, ... }: {
  options = {
    hyprland.enable = lib.mkEnableOption "Enables hyprland";
  };
  config = lib.mkIf config.hyprland.enable {
    programs.hyprland.enable = true;
  };
}
