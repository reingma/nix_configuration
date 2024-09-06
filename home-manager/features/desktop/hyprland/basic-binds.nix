{ lib, ... }:
{
  wayland.windowManager.hyprland.settings = {
    bindm = [
      "SUPER,mouse:272,movewindow"
      "SUPER,mouse:273,resizewindow"
    ];
    bind =
      let
        workspaces = [
          "0"
          "1"
          "2"
          "3"
          "4"
          "5"
          "6"
          "7"
          "8"
          "9"
        ];
        directions = rec {
          left = "l";
          right = "r";
          up = "u";
          down = "d";
          h = left;
          l = right;
          k = up;
          j = down;
        };
      in
      [
        "SUPER,q,killactive"
        "SUPERSHIFT,e,exit"
        "SUPER,s,togglesplit"
        "SUPER,f,fullscreen,0"
        "SUPERSHIFT,f,fullscreen,1"
        "SUPERSHIFT,backspace,togglefloating"

        "SUPER,minus,splitratio,-0.25"
        "SUPERSHIFT,minus,splitratio,-0.33333"

        "SUPER,g,togglegroup"
        "SUPER,t,lockactivegroup,toggle"
        "SUPER,tab,changegroupactive,f"
        "SUPERSHIFT,tab,changegroupactive,b"

        "SUPER,apostrophe,workspace,previous"
        "SUPERSHIFT,apostrophe,workspace,next"

        "SUPER,a,togglespecialworkspace"
        "SUPERSHIFT,a,movetoworkspacesilent,special"
      ]
      ++ (map (n: "SUPER,${n},workspace,name:${n}") workspaces)
      ++ (map (n: "SUPERSHIFT,${n},movetoworkspacesilent,name:${n}") workspaces)
      ++ (lib.mapAttrsToList (key: direction: "SUPER,${key},movefocus,${direction}") directions)
      ++ (lib.mapAttrsToList (key: direction: "SUPERSHIFT,${key},swapwindow,${direction}") directions)
      ++ (lib.mapAttrsToList (
        key: direction: "SUPERCONTROL,${key},movewindoworgroup,${direction}"
      ) directions);
  };
}
