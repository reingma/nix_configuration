{ lib, ... }: {
  wayland.windowManager.hyprland.settings = {
    bindm = [ "SUPER,mouse:272,movewindow" "SUPER,mouse:273,resizewindow" ];
    bind = let
      workspaces = [ "0" "1" "2" "3" "4" "5" "6" "7" "8" "8" ];
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
    in [
      "ALTSHIFT,x,killactive"
      "ALTSHIFT,e,exit"
      "ALT,s,togglesplit"
      "ALT,f,fullscreen,1"
      "ALTSHIFT,f,fullscreen,0"
      "ALTSHIFT,backspace,togglefloating"

      "ALT,minus,splitratio,-0.25"
      "ALTSHIFT,minus,splitratio,-0.33333"

      "ALT,g,togglegroup"
      "ALT,t,lockactivegroup,toggle"
      "ALT,tab,changegroupactive,f"
      "ALTSHIFT,tab,change,groupactive,b"

      "ALT,apostrophe,workspace,previous"
      "ALTSHIFT,apostrophe,workspace,next"

      "ALT,a,togglespecialworkspace"
      "ALTSHIFT,a,movetoworkspacesilent,special"
    ] ++ (map (n: "ALT,${n},workspace,name:${n}") workspaces)
    ++ (map (n: "ALTSHIFT,${n},movetoworkspacesilent,name:${n}") workspaces)
    ++ (lib.mapAttrsToList (key: direction: "ALT,${key},movefocus,${direction}")
      directions) ++ (lib.mapAttrsToList
        (key: direction: "ALTSHIFT,${key},swapwindow,${direction}") directions)
    ++ (lib.mapAttrsToList
      (key: direction: "ALTCONTROL,${key},movewindoworgroup,${direction}")
      directions);
  };
}
