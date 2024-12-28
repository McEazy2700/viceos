{ config, pkgs, inputs, ... }:

{
  home.username = "vice";
  home.homeDirectory = "/home/vice";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "24.11"; # Please read the comment before changing.
  home.packages = with pkgs; [
    pkgs.hello
    papirus-icon-theme
    font-awesome
    libsForQt5.breeze-icons

    libuuid
    gcc-unwrapped.lib
    stdenv.cc.cc.lib
    gcc
    libgcc
    gnumake
    cmake
    extra-cmake-modules
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
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  home.sessionVariables = {
    # EDITOR = "emacs";
  };


  imports = [
    ./modules/apps.nix
    ./modules/stylix.nix
    ./modules/waybar.nix
    ./modules/dev.nix
    ./modules/yazi.nix
    ./modules/hyprland.nix
    ./modules/dfx.nix
  ];

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
