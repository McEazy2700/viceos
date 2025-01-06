{ config
, lib
, pkgs
, ...
}: {
  home.packages = with pkgs; [
    wl-clipboard # Clipboard manager
    waybar # Status bar
    swww # Wallpaper
    wofi
    dunst # Notification daemon
    libnotify # For sending notifications
    swaylock # Screen locker
    swayidle # Idle management daemon
    brightnessctl # Brightness control
    pamixer # Volume control
    networkmanager # Network management
    grim # Screenshot tool
    slurp # Select a region
    wl-clipboard # Clipboard tool
    swappy # Screenshot editor
  ];

  services.hypridle = {
    enable = true;
    settings = {
      general = {
        before_sleep_cmd = "loginctl lock-session";
        after_sleep_cmd = "hyprctl dispatch dpms on";
        ignore_dbus_inhibit = false;
        lock_cmd = "pidof hyprlock || hyprlock";
      };

      listener = [
        {
          timeout = 180;
          on-timeout = "brightnessctl -s set 30";
          on-resume = "brightnessctl -r";
        }
        {
          timeout = 300;
          on-timeout = "loginctl lock-session";
        }
        {
          timeout = 600;
          on-timeout = "hyprctl dispatch dpms off";
          on-resume = "hyprctl dispatch dpms on";
        }
        {
          timeout = 1200;
          on-timeout = "sysemctl suspend";
        }
      ];
    };
  };

  programs.hyprlock = {
    enable = true;
    settings = {
      general = {
        disable_loading_bar = true;
        grace = 10;
        hide_cursor = true;
        no_fade_in = false;
      };

      label = {
        text = "$TIME";
        font_size = 96;
        position = "0, 600";
        halign = "center";
        walign = "center";

        shadow_passes = 1;
      };
    };
  };

  services.hyprpaper = {
    enable = true;
  };

  wayland.windowManager.hyprland = {
    enable = true;
    systemd.enable = true;
    extraConfig = ''
      general {
        gaps_in = 5
        gaps_out = 5
        border_size = 2
        resize_on_border = true
        allow_tearing = false
        layout = dwindle
      }
    '';
    settings = {
      bind = [
        "$mainMod, Return, exec, $terminal"
        "$mainMod SHIFT, Q, killactive,"
        "$mainMod SHIFT, BACKSPACE, exec, ~/.config/rofi/powermenu/type-5/powermenu.sh"
        "$mainMod,       R, exec, $fileManager"
        "$mainMod,       E, exec, nautilus"
        "$mainMod,       SPACE, togglefloating,"
        "$mainMod,       F, fullscreen,"
        "$mainMod,       D, exec, /home/vice/.config/rofi/launchers/type-7/launcher.sh"
        "$mainMod,       P, pseudo,"
        "$mainMod,       J, togglesplit,"
        "$mainMod,       V, exec, cliphist list | $menu --dmenu | cliphist decode | wl-copy"
        "$mainMod,       B, exec, pkill -SIGUSR2 waybar"
        "$mainMod SHIFT, B, exec, pkill -SIGUSR1 waybar"
        "$mainMod,       L, exec, loginctl lock-session"
        "$mainMod,       P, exec, hyprpicker -an"
        "$mainMod,       N, exec, swaync-client -t"
        ", Print, exec, grimblast --notify --freeze copysave area"
        ''$mainMod SHIFT, S, exec, grim -g "$(slurp)" - | swappy -f -''

        # Moving focus
        "$mainMod, left, movefocus, l"
        "$mainMod, right, movefocus, r"
        "$mainMod, up, movefocus, u"
        "$mainMod, down, movefocus, d"

        # Moving windows
        "$mainMod SHIFT, left,  swapwindow, l"
        "$mainMod SHIFT, right, swapwindow, r"
        "$mainMod SHIFT, up,    swapwindow, u"
        "$mainMod SHIFT, down,  swapwindow, d"

        # Resizeing windows                   X  Y
        "$mainMod CTRL, left,  resizeactive, -60 0"
        "$mainMod CTRL, right, resizeactive,  60 0"
        "$mainMod CTRL, up,    resizeactive,  0 -60"
        "$mainMod CTRL, down,  resizeactive,  0  60"

        # Switching workspaces
        "$mainMod, 1, workspace, 1"
        "$mainMod, 2, workspace, 2"
        "$mainMod, 3, workspace, 3"
        "$mainMod, 4, workspace, 4"
        "$mainMod, 5, workspace, 5"
        "$mainMod, 6, workspace, 6"
        "$mainMod, 7, workspace, 7"
        "$mainMod, 8, workspace, 8"
        "$mainMod, 9, workspace, 9"
        "$mainMod, 0, workspace, 10"

        # Moving windows to workspaces
        "$mainMod SHIFT, 1, movetoworkspacesilent, 1"
        "$mainMod SHIFT, 2, movetoworkspacesilent, 2"
        "$mainMod SHIFT, 3, movetoworkspacesilent, 3"
        "$mainMod SHIFT, 4, movetoworkspacesilent, 4"
        "$mainMod SHIFT, 5, movetoworkspacesilent, 5"
        "$mainMod SHIFT, 6, movetoworkspacesilent, 6"
        "$mainMod SHIFT, 7, movetoworkspacesilent, 7"
        "$mainMod SHIFT, 8, movetoworkspacesilent, 8"
        "$mainMod SHIFT, 9, movetoworkspacesilent, 9"
        "$mainMod SHIFT, 0, movetoworkspacesilent, 10"
      ];

      # Move/resize windows with mainMod + LMB/RMB and dragging
      bindm = [
        "$mainMod, mouse:272, movewindow"
        "$mainMod, mouse:273, resizewindow"
      ];

      # Laptop multimedia keys for volume and LCD brightness
      bindel = [
        ",XF86AudioRaiseVolume,  exec, wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"
        ",XF86AudioLowerVolume,  exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
        ",XF86AudioMute,         exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
        ",XF86AudioMicMute,      exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"
        "$mainMod, bracketright, exec, brightnessctl s 10%+"
        "$mainMod, bracketleft,  exec, brightnessctl s 10%-"
      ];

      # Audio playback
      bindl = [
        ", XF86AudioNext,  exec, playerctl next"
        ", XF86AudioPause, exec, playerctl play-pause"
        ", XF86AudioPlay,  exec, playerctl play-pause"
        ", XF86AudioPrev,  exec, playerctl previous"
      ];

      env = [
        # Hint Electron apps to use Wayland
        "NIXOS_OZONE_WL,1"
        "XDG_CURRENT_DESKTOP,Hyprland"
        "XDG_SESSION_TYPE,wayland"
        "XDG_SESSION_DESKTOP,Hyprland"
        "QT_QPA_PLATFORM,wayland"
        "XDG_SCREENSHOTS_DIR,$HOME/screens"
      ];

      "$fileManager" = "$terminal -e sh -c 'yazi'";
      "$mainMod" = "SUPER";
      "$menu" = "wofi";
      "$terminal" = "kitty";
      monitor = ",1920x1080@60,auto,1";

      exec-once = [
        "waybar"
        "wl-paste --type text --watch cliphist store"
        "wl-paste --type image --watch cliphist store"
      ];

      input = {
        kb_layout = "us";
        follow_mouse = 1;
        touchpad = {
          natural_scroll = true;
        };
        sensitivity = 0; # -1.0 - 1.0, 0 means no modification.
      };

      decoration = {
        rounding = 10;
        blur = {
          enabled = true;
          size = 10;
          passes = 2;
          new_optimizations = true;
        };
        shadow = {
          range = 4;
          render_power = 3;
        };
      };

      animations = {
        enabled = true;
        bezier = "ease,0.4,0.02,0.21,1";
        animation = "windows, 1, 3.5, ease, slide";
      };

      dwindle = {
        pseudotile = true;
        preserve_split = true;
      };

      master = {
        new_status = "slave";
        new_on_top = true;
        mfact = 0.5;
      };

      gestures = {
        workspace_swipe = true;
        workspace_swipe_invert = true;
        workspace_swipe_forever = true;
      };

      windowrulev2 = [
        "bordersize 0, floating:0, onworkspace:w[t1]"

        "float,class:(mpv)|(imv)|(showmethekey-gtk)"
        "move 990 60,size 900 170,pin,noinitialfocus,class:(showmethekey-gtk)"
        "noborder,nofocus,class:(showmethekey-gtk)"

        "workspace 3,class:(obsidian)"
        "workspace 3,class:(zathura)"
        "workspace 4,class:(com.obsproject.Studio)"
        "workspace 5,class:(telegram)"
        "workspace 5,class:(vesktop)"
        "workspace 6,class:(teams-for-linux)"

        "suppressevent maximize, class:.*"
        "nofocus,class:^$,title:^$,xwayland:1,floating:1,fullscreen:0,pinned:0"

        "noanim, class:^(xwaylandvideobridge)$"
        "noinitialfocus, class:^(xwaylandvideobridge)$"
        "maxsize 1 1, class:^(xwaylandvideobridge)$"
        "noblur, class:^(xwaylandvideobridge)$"
        "nofocus, class:^(xwaylandvideobridge)$"
      ];
    };
  };
}
