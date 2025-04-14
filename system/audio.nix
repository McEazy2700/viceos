{ config, pkgs, ... }:
{
  hardware.firmware = [
    pkgs.sof-firmware
    pkgs.alsa-firmware
  ];

  boot.extraModprobeConfig = ''
    options snd-intel-dspcfg dsp_driver=3
    options snd-hda-intel model=alc285-sense-combo
  '';

  # Add UCM profiles for ALC285
  environment.etc."ucm2/sof-hda-dsp/HiFi.conf".text = ''
    SectionVerb {
        EnableSequence [
            cdev "hw:sofhdadsp"
        ]
    }

    SectionDevice."Headphone" {
        Value {
            PlaybackPCM "hw:sofhdadsp,0"
            JackSwitch "Headphone Jack"
        }
        EnableSequence [
            cset "name='Headphone Playback Switch' on"
            cset "name='Headphone Playback Volume' 60"
        ]
    }
  '';

  services.pipewire.wireplumber.configPackages = [
    (pkgs.writeTextDir "share/wireplumber/main.lua.d/99-headphone-fix.lua" ''
      rule = {
        matches = {
          {
            { "node.name", "matches", "alsa_output.*.analog-stereo" },
            { "device.name", "matches", "alsa_card.*" }
          }
        },
        apply_properties = {
          ["audio.format"] = "S16LE",
          ["audio.rate"] = 48000,
          ["api.alsa.use-acp"] = true,
          ["device.profile"] = "HiFi",
          ["node.description"] = "Headphones",
          ["priority.driver"] = 3000
        }
      }
      table.insert(alsa_monitor.rules, rule)
    '')
  ];

  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    jack.enable = true;
    audio.enable = true;
  };
}
