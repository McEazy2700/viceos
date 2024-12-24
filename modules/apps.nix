{ pkgs, ... }: {
  home.packages = with pkgs; [
    vivaldi
    discord
  ];
  programs.mpv.enable = true;
}
