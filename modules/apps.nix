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
    neovim = {
      enable = true;

      # This is important for Lazy
      withNodeJs = true; # If you need Node.js support
      withPython3 = true; # If you need Python support
    };
  };

  # Allow Lazy plugin manager to operate in a writable directory
  home.file.".local/share/nvim/lazy".source =
    config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.local/state/nvim/lazy";

  # Create the directory structure
  home.activation.createLazyDir = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    mkdir -p $HOME/.local/state/nvim/lazy
  '';
}
