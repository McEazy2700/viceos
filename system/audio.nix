{ config, pkgs, ... }:
{
  sound.extraConfig = ''
    defaults.pcm.!card Headphones
    defaults.ctl.!card Headphones
  '';

  environment.etc."asound.conf".text = ''
    defaults.pcm.!card Headphones
    defaults.ctl.!card Headphones
  '';
}
