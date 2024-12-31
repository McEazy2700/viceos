{ pkgs, ... }:
{
  home.packages = with pkgs; [
    usbutils
    vivaldi
    discord
  ];
  programs.mpv.enable = true;
  programs.btop.enable = true;
  programs.obs-studio = {
    enable = true;
    plugins = with pkgs.obs-studio-plugins;[
      wlrobs
      obs-backgroundremoval
      obs-pipewire-audio-capture
    ];
  };
}
