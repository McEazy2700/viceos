{ pkgs, ... }: {
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  services.acpid.enable = true;

  environment.etc = {
    "acpi/events/headphone-plug" = {
      text = ''
        event=jack/headphone HEADPHONE plug
        action=${pkgs.writeShellScript "headphone-plug" ''
          #! ${pkgs.bash}/bin/bash
          ${pkgs.alsa-utils}/bin/amixer -c 0 sset "Headphone" on
          ${pkgs.alsa-utils}/bin/amixer -c 0 sset "Speaker" off
          ${pkgs.alsa-utils}/bin/amixer -c 0 sset "Bass Speaker" off
        ''}
      '';
      mode = "0644";
    };

    "acpi/events/headphone-unplug" = {
      text = ''
        event=jack/headphone HEADPHONE unplug
        action=${pkgs.writeShellScript "headphone-unplug" ''
          #! ${pkgs.bash}/bin/bash
          ${pkgs.alsa-utils}/bin/amixer -c 0 sset "Headphone" off
          ${pkgs.alsa-utils}/bin/amixer -c 0 sset "Speaker" on
          ${pkgs.alsa-utils}/bin/amixer -c 0 sset "Bass Speaker" on
        ''}
      '';
      mode = "0644";
    };
  };

  # Also create a one-time service to set initial audio state on boot
  systemd.services.initial-audio-setup = {
    description = "Set initial audio state";
    wantedBy = [ "multi-user.target" ];
    script = ''
      # Check if headphones are plugged in on boot
      if [ -e /sys/class/sound/card0/hwC0D0/jack_headphone ] && [ "$(cat /sys/class/sound/card0/hwC0D0/jack_headphone)" = "1" ]; then
        # Headphones are plugged in
        ${pkgs.alsa-utils}/bin/amixer -c 0 sset "Headphone" on
        ${pkgs.alsa-utils}/bin/amixer -c 0 sset "Speaker" off
        ${pkgs.alsa-utils}/bin/amixer -c 0 sset "Bass Speaker" off
      else
        # No headphones
        ${pkgs.alsa-utils}/bin/amixer -c 0 sset "Headphone" off
        ${pkgs.alsa-utils}/bin/amixer -c 0 sset "Speaker" on
        ${pkgs.alsa-utils}/bin/amixer -c 0 sset "Bass Speaker" on
      fi
    '';
    serviceConfig = {
      Type = "oneshot";
      User = "root";
      RemainAfterExit = true;
    };
  };

  environment.systemPackages = with pkgs; [
    pulseaudio
    pulseaudio-ctl
    pavucontrol
    pamixer
    alsa-utils
  ];
}
