{ pkgs, ... }:
{
  imports = [
    ./mako.nix
    ./wofi.nix
    ./imv.nix
    ./waybar.nix
  ];
  xdg.mimeApps.enable = true;
  home.packages = with pkgs; [
    wf-recorder
    wl-clipboard
  ];
  home.sessionVariables = {
    MOZ_ENABLE_WAYLAND = 1;
    QT_QPA_PLATAFORM = "wayland";
    LIBSEAT_BACKEND = "logind";
  };
}
