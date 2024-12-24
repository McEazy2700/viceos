{ pkg, ... }: {
  home.packages = with pkgs; [
    vivaldi
  ];
  programs.mpv = {
    enable = true;
  };
}
