{ config, lib, pkgs, ... }:

{
  programs.eww = {
    enable = true;
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
