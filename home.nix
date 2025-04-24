{ pkgs
, lib
, ...
}: {
  nixpkgs.config.allowUnfree = true;
  home = {
    username = "vice";
    homeDirectory = "/home/vice";
    stateVersion = "24.11"; # Please read the comment before changing.
  };

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.packages = with pkgs; [
    pkgs.hello
    papirus-icon-theme
    font-awesome
    libsForQt5.breeze-icons
    eww

    libuuid
    gcc-unwrapped.lib
    stdenv.cc.cc.lib
    gcc
    libgcc
    gnumake
    cmake
    extra-cmake-modules

    xorg.libX11
    xorg.libXrandr
    libxkbcommon
    wayland
    openssl
    openssl.dev

    # Tauri
    zlib
    zlib.dev
    zlib.static
    pkg-config
    at-spi2-atk
    atkmm
    cairo
    cairo.dev
    gdk-pixbuf
    gdk-pixbuf.dev
    glib
    gtk3
    harfbuzz
    libsoup_3
    pango
    librsvg.dev
    webkitgtk_4_1
    webkitgtk_4_1.dev
    atk
    gtk3-x11
    adwaita-icon-theme
    libunwind
  ];
  gtk = {
    enable = true;
    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.papirus-icon-theme;
    };
  };

  qt = {
    enable = true;
    platformTheme.name = "gtk"; # This makes Qt apps use your GTK theme
  };
  home.activation = {
    createRofiDirs = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
      mkdir -p ~/.config/rofi/colors
      mkdir -p ~/.config/rofi/scripts
    '';
  };
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;
    ".config/nvim" = {
      source = builtins.path { path = ./configs/astrovim_config; };
      recursive = true;
    };
    ".config/eww" = {
      source = pkgs.lib.cleanSource ./configs/eww;
      recursive = true;
      force = true;
    };
    ".config/rofi" = {
      source = ./configs/rofi;
      recursive = true;
      force = true;
    };

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  home.sessionVariables = {
    PKG_CONFIG_PATH = "${pkgs.lib.makeSearchPath "lib/pkgconfig" [
      pkgs.librsvg.dev
      pkgs.gdk-pixbuf.dev
      pkgs.openssl.dev
      pkgs.glib.dev
      pkgs.gtk3.dev
      pkgs.cairo.dev
      pkgs.pango.dev
      pkgs.harfbuzz.dev
      pkgs.webkitgtk_4_1.dev
      pkgs.atk.dev
      pkgs.gdk-pixbuf.dev
      pkgs.libsoup_3.dev
      pkgs.zlib.dev
    ]}";

    LIBRARY_PATH = "${pkgs.lib.makeLibraryPath [
      pkgs.zlib
      pkgs.zlib.dev
    ]}";

    LD_LIBRARY_PATH = "${pkgs.lib.makeLibraryPath [
      pkgs.zlib
      pkgs.zlib.dev
      pkgs.stdenv.cc.cc.lib
      pkgs.libunwind
    ]}";
  };

  nixpkgs.config.permittedInsecurePackages = [
    "python-2.7.18.8"
  ];

  imports = [
    ./modules/apps.nix
    ./modules/stylix.nix
    ./modules/waybar.nix
    ./modules/dev.nix
    ./modules/yazi.nix
    ./modules/hyprland.nix
    ./modules/dfx.nix
    ./modules/freeshow.nix
    ./modules/nixvim/default.nix
    ./modules/nvf/default.nix
    ./modules/zenbrowser.nix
    # ./modules/eww.nix
  ];

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
