{
  outputs,
  config,
  lib,
  pkgs,
  inputs,
  ...
}:
let
  commonDeps = with pkgs; [
    coreutils
    gnugrep
    systemd
  ];
  # Function to simplify making waybar outputs
  mkScript =
    {
      name ? "script",
      deps ? [ ],
      script ? "",
    }:
    lib.getExe (
      pkgs.writeShellApplication {
        inherit name;
        text = script;
        runtimeInputs = commonDeps ++ deps;
      }
    );
  # Specialized for JSON outputs
  mkScriptJson =
    {
      name ? "script",
      deps ? [ ],
      pre ? "",
      text ? "",
      tooltip ? "",
      alt ? "",
      class ? "",
      percentage ? "",
    }:
    mkScript {
      deps = [ pkgs.jq ] ++ deps;
      script = ''
        ${pre}
        jq -cn \
          --arg text "${text}" \
          --arg tooltip "${tooltip}" \
          --arg alt "${alt}" \
          --arg class "${class}" \
          --arg percentage "${percentage}" \
          '{text:$text,tooltip:$tooltip,alt:$alt,class:$class,percentage:$percentage}'
      '';
    };

  hyprlandCfg = config.wayland.windowManager.hyprland;
in
{
  # Let it try to start a few more times
  systemd.user.services.waybar = {
    Unit.StartLimitBurst = 30;
  };
  programs.waybar = {
    enable = true;
    package = pkgs.waybar.overrideAttrs (oa: {
      mesonFlags = (oa.mesonFlags or [ ]) ++ [ "-Dexperimental=true" ];
    });
    systemd.enable = true;
    settings = {
      primary = {
        exclusive = false;
        passthrough = false;
        height = 40;
        margin = "6";
        position = "top";
        modules-left =
          [ "custom/menu" ]
          ++ (lib.optionals hyprlandCfg.enable [
            "hyprland/workspaces"
            "hyprland/submap"
          ])
          ++ [
            "custom/currentplayer"
            "custom/player"
          ];

        modules-center = [
          "cpu"
          "memory"
          "clock"
          "pulseaudio"
          "battery"
        ];

        modules-right = [
          "network"
          "tray"
          "custom/hostname"
        ];

        clock = {
          interval = 1;
          format = "{:%d/%m %H:%M:%S}";
          format-alt = "{:%Y-%m-%d %H:%M:%S %z}";
          on-click-left = "mode";
          tooltip-format = ''
            <big>{:%Y %B}</big>
            <tt><small>{calendar}</small></tt>'';
        };

        cpu = {
          format = "  {usage}%";
        };
        memory = {
          format = "  {}%";
          interval = 5;
        };

        pulseaudio = {
          format = "{icon}  {volume}%";
          format-muted = "   0%";
          format-icons = {
            headphone = "󰋋";
            headset = "󰋎";
            portable = "";
            default = [
              ""
              ""
              ""
            ];
          };
          on-click = lib.getExe pkgs.pavucontrol;
        };
        idle_inhibitor = {
          format = "{icon}";
          format-icons = {
            activated = "󰒳";
            deactivated = "󰒲";
          };
        };
        battery = {
          bat = "BAT0";
          interval = 10;
          format-icons = [
            "󰁺"
            "󰁻"
            "󰁼"
            "󰁽"
            "󰁾"
            "󰁿"
            "󰂀"
            "󰂁"
            "󰂂"
            "󰁹"
          ];
          format = "{icon} {capacity}%";
          format-charging = "󰂄 {capacity}%";
          onclick = "";
        };
        network = {
          interval = 3;
          format-wifi = "   {essid}";
          format-ethernet = "󰈁 Connected";
          format-disconnected = "";
          tooltip-format = ''
            {ifname}
            {ipaddr}/{cidr}
            Up: {bandwidthUpBits}
            Down: {bandwidthDownBits}'';
        };
        "custom/menu" = {
          interval = 1;
          return-type = "json";
          exec = mkScriptJson {
            deps = lib.optional hyprlandCfg.enable hyprlandCfg.package;
            text = "";
            tooltip = ''$(grep /etc/os-release PRETTY_NAME | cut -d '"' -f2)'';
            class =
              let
                isFullScreen =
                  if hyprlandCfg.enable then "hyprctl activewindow -j | jq -e '.fullscreen' &>/dev/null" else "false";
              in
              "$(if ${isFullScreen}; then echo fullscreen; fi)";
          };
        };
        "custom/hostname" = {
          exec = mkScript { script = ''echo "$USER@$HOSTNAME"''; };
          on-click = mkScript { script = "systemctl --user restart waybar"; };
        };
        "custom/currentplayer" = {
          interval = 2;
          return-type = "json";
          exec = mkScriptJson {
            deps = [ pkgs.playerctl ];
            pre = ''
              player="$(playerctl status -f "{{playerName}}" 2>/dev/null || echo "No player active" | cut -d '.' -f1)"
              count="$(playerctl -l 2>/dev/null | wc -l)"
              if ((count > 1)); then
                more=" +$((count - 1))"
              else
                more=""
              fi
            '';
            alt = "$player";
            tooltip = "$player ($count available)";
            text = "$more";
          };
          format = "{icon}{}";
          format-icons = {
            "No player active" = " ";
            "Celluloid" = "󰎁 ";
            "spotify" = "󰓇 ";
            "ncspot" = "󰓇 ";
            "qutebrowser" = "󰖟 ";
            "firefox" = " ";
            "discord" = " 󰙯 ";
            "sublimemusic" = " ";
            "kdeconnect" = "󰄡 ";
            "chromium" = " ";
          };
        };
        "custom/rfkill" = {
          interval = 1;
          exec-if = mkScript {
            deps = [ pkgs.util-linux ];
            script = "rfkill | grep '<blocked>'";
          };
        };
        "custom/player" = {
          exec-if = mkScript {
            deps = [ pkgs.playerctl ];
            script = "playerctl status 2>/dev/null";
          };
          exec =
            let
              format = ''{"text": "{{title}} - {{artist}}", "alt": "{{status}}", "tooltip": "{{title}} - {{artist}} ({{album}})"}'';
            in
            mkScript {
              deps = [ pkgs.playerctl ];
              script = "playerctl metadata --format '${format}' 2>/dev/null";
            };
          return-type = "json";
          interval = 2;
          max-length = 30;
          format = "{icon} {}";
          format-icons = {
            "Playing" = "󰐊";
            "Paused" = "󰏤 ";
            "Stopped" = "󰓛";
          };
          on-click = mkScript {
            deps = [ pkgs.playerctl ];
            script = "playerctl play-pause";
          };
        };
      };
    };
    # Cheatsheet:
    # x -> all sides
    # x y -> vertical, horizontal
    # x y z -> top, horizontal, bottom
    # w x y z -> top, right, bottom, left
    style =
      let
        inherit (inputs.nix-colors.lib.conversions) hexToRGBString;
        inherit (config.colorScheme) palette;
        toRGBA = color: opacity: "rgba(${hexToRGBString "," color},${opacity})";
      in
      # css
      ''
        * {
          font-family: ${config.fontProfiles.regular.family}, ${config.fontProfiles.monospace.family};
          font-size: 12pt;
          padding: 0;
          margin: 0 0.4em;
        }

        window#waybar {
          padding: 0;
          border-radius: 0.5em;
          background-color: #${palette.base00};
          color: #${palette.base05};
        }
        .modules-left {
          margin-left: -0.65em;
        }
        .modules-right {
          margin-right: -0.65em;
        }

        #workspaces button {
          background-color: ${toRGBA palette.base00 "0.7"};
          color: #${palette.base05};
          padding-left: 0.4em;
          padding-right: 0.4em;
          margin-top: 0.15em;
          margin-bottom: 0.15em;
        }
        #workspaces button.hidden {
          background-color: #${palette.base00};
          color: #${palette.base05};
        }
        #workspaces button.focused,
        #workspaces button.active {
          background-color: ${toRGBA palette.base0B "0.3"};
          color: #${palette.base05};
        }

        #clock {
          padding-right: 1em;
          padding-left: 1em;
          border-radius: 0.5em;
        }

        #custom-menu {
          background-color: #${palette.base00};
          padding-right: 1.5em;
          padding-left: 1em;
          margin-right: 0;
          border-radius: 0.5em;
        }
        #custom-menu.fullscreen {
          background-color: #${palette.base01};
          color: #${palette.base01};
        }
        #custom-hostname {
          padding-right: 1em;
          padding-left: 1em;
          margin-left: 0;
          border-radius: 0.5em;
        }
        #custom-currentplayer {
          padding-right: 0;
        }
        #tray {
          color: #${palette.base05};
        }
        #custom-gpu, #cpu, #memory {
          margin-left: 0.05em;
          margin-right: 0.55em;
        }
      '';
  };
}
