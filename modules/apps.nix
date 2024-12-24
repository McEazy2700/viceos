{ pkgs, ... }: {
  home.packages = with pkgs; [
    vivaldi
    discord
    whatsapp-for-linux
  ];
  programs.mpv.enable = true;
}
