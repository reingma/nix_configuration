{ config, lib, pkgs, ... }: {
  options = { hyprland.enable = lib.mkEnableOption "enable hyprland desktop"; };
  imports = [ ../common ../common/wayland ./basic-binds.nix ];
  config = lib.mkIf config.hyprland.enable {
    wayland.windowManager.hyprland = {
      enable = true;
      systemd = {
        enable = true;
        extraCommands = lib.mkBefore [
          "systemctl --user stop graphical-session.target"
          "systemctl --user start hyprland-session.target"
        ];
      };
      settings = let
        active = "0xaa${config.colorScheme.palette.base0D}";
        inactive = "0xaa${config.colorScheme.palette.base0F}";
      in {
        general = {
          cursor_inactive_timeout = 4;
          gaps_in = 15;
          gaps_out = 20;
          border_size = 2;
          "col.active_border" = active;
          "col.inactive_border" = inactive;
        };
        group = {
          "col.border_active" = active;
          "col.border_inactive" = inactive;
          groupbar.font_size = 11;
        };
        binds = { movefocus_cycles_fullscreen = false; };
        input = {
          kb_layout = "us";
          touchpad.disable_while_typing = false;
        };
        dwindle = {
          split_width_multiplier = 1.35;
          pseudotile = true;
        };
        misc = {
          vfr = true;
          close_special_on_empty = true;
          focus_on_activate = true;
        };
        layerrule = [
          "animation fade,waybar"
          "blur,waybar"
          "ignorezero,waybar"
          "blur,notifications"
          "ignorezero,notifications"
          "blur,wofi"
          "ignorezero,wofi"
          "noanim,wallpaper"
        ];

        decoration = {
          active_opacity = 0.97;
          inactive_opacity = 0.77;
          fullscreen_opacity = 1.0;
          rounding = 7;
          blur = {
            enabled = true;
            size = 5;
            passes = 3;
            new_optimizations = true;
            ignore_opacity = true;
            popups = true;
          };
          drop_shadow = true;
          shadow_range = 12;
          shadow_offset = "3 3";
          "col.shadow" = "0x44000000";
          "col.shadow_inactive" = "0x66000000";
        };
        animations = {
          enabled = true;
          bezier = [
            "easein,0.11, 0, 0.5, 0"
            "easeout,0.5, 1, 0.89, 1"
            "easeinout,0.45, 0, 0.55, 1"
            "easeinback,0.36, 0, 0.66, -0.56"
            "easeoutback,0.34, 1.56, 0.64, 1"
            "easeinoutback,0.68, -0.6, 0.32, 1.6"
          ];
          animation = [
            "border,1,3,easeout"
            "workspaces,1,2,easeoutback,slide"
            "windowsIn,1,3,easeoutback,slide"
            "windowsOut,1,3,easeinback,slide"
            "windowsMove,1,3,easeoutback"
            "fasdeIn,1,3,easeout"
            "fadeOut,1,3,easein"
            "fadeSwitch,1,3,easeinout"
            "fadeShadow,1,3,easeinout"
            "fadeDim,1,3,easeinout"
            "fadeLayersIn,1,3,easeoutback"
            "fadeLayersOut,1,3,easeinback"
            "layersIn,1,3,easeoutback,slide"
            "layersOut,1,3,easeinback,slide"
          ];
        };
        exec =
          [ "${pkgs.swaybg}/bin/swaybg -i ${config.wallpaper} --mode fill" ];
        bind = let
          defaultApp = type: "${lib.getExe pkgs.handlr-regex} launch ${type}";
        in
        [
          "ALT,q,exec,${defaultApp "x-scheme-handler/terminal"}"
          "ALT,e,exec,${defaultApp "text/plain"}"
          "ALT,b,exec,${defaultApp "x-scheme-handler/https"}"
        ];
      };
    };
  };
}
