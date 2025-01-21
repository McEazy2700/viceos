{ pkgs, ... }: {
  home.packages = with pkgs; [
    microsoft-edge
    usbutils
    vivaldi
    discord
    ueberzug
    ffmpegthumbnailer
    poppler
    imagemagick
    inkscape
    pciutils
    atlas
    qimgv
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
