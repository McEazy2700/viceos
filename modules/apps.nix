{ pkgs
, config
, lib
, ...
}: {
  home = {
    packages = with pkgs; [
      microsoft-edge
      usbutils
      discord
      ueberzug
      ffmpegthumbnailer
      poppler
      imagemagick
      inkscape
      pciutils
      obsidian
      atlas
      jq
      ccze
      grc
      tree
      anydesk
      firefox-devedition-bin
      opera
    ];
  };
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
      defaultEditor = true;

      # This is important for Lazy
      withPython3 = true; # If you need Python support
    };
  };

  # Create a symlink instead
  home.activation.linkAstroVimConfig = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    # Remove existing config if it exists
    if [ -e $HOME/.config/nvim ]; then
      rm -rf $HOME/.config/nvim
    fi

    # Create symlink
    ln -sf $HOME/.dotfile/viceos/configs/astrovim_config $HOME/.config/nvim
  '';
}
