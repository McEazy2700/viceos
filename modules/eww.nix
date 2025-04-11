{ config, lib, pkgs, ... }:

{
  programs.eww = {
    enable = true;
    package = pkgs.eww-wayland;
    configDir = ../configs/eww;
  };

  home.packages = with pkgs; [
    bash
    coreutils
    jq
    socat
    wofi # Better Wayland app launcher
  ];
}
