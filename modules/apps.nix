{ pkgs, config, lib, ... }: {
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

  home.activation.neovimLazyFix = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    mkdir -p $HOME/.local/state/nvim
    # Create an empty lockfile if it doesn't exist
    touch $HOME/.local/state/nvim/lazy-lock.json
  '';

  # Optional: If you want to maintain the appearance of the lockfile in your config
  home.file.".config/nvim/lazy-lock.json".source =
    config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.local/state/nvim/lazy-lock.json";

  # Allow Lazy plugin manager to operate in a writable directory
  home.file.".local/share/nvim/lazy".source =
    config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.local/state/nvim/lazy";

  # Create the directory structure
  home.activation.createLazyDir = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    mkdir -p $HOME/.local/state/nvim/lazy
  '';
}
