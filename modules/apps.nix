{ pkgs, ... }: {
  home.packages = with pkgs; [
    microsoft-edge
    usbutils
    discord
    ueberzug
    ffmpegthumbnailer
    poppler
    imagemagick
    inkscape
    pciutils
    atlas
    jq
    ccze
    grc
    tree
    anydesk
    opera
    libunwind
  ];
  programs = {
    cava.enable = true;
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
