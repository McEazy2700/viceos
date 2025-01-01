{ pkgs, ... }: {
  home.packages = with pkgs; [
    usbutils
    vivaldi
    discord
    ueberzug
    ffmpegthumbnailer
    poppler
    imagemagick
  ];
  programs = {
    mpv.enable = true;
    btop.enable = true;
    obs-studio = {
      enable = true;
      plugins = with pkgs.obs-studio-plugins; [
        wlrobs
        obs-backgroundremoval
        obs-pipewire-audio-capture
      ];
    };
  };
}
