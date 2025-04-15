{pkgs, ...}: {
  stylix = {
    enable = true;
    autoEnable = true;
    image = ../Wallpapers/one-piece-monkey-d-luffy-peaceful-sea-desktop-wallpaper.jpg;
    polarity = "dark";

    cursor.package = pkgs.bibata-cursors;
    cursor.name = "Bibata-Modern-Ice";

    fonts = {
      monospace = {
        package = pkgs.nerd-fonts.fira-code;
        name = "FiraCode Nerd Font";
      };

      serif = {
        package = pkgs.dejavu_fonts;
        name = "DejaVu Serif";
      };

      sansSerif = {
        package = pkgs.dejavu_fonts;
        name = "DejaVu Sans";
      };

      emoji = {
        package = pkgs.noto-fonts-emoji;
        name = "Noto Color Emoji";
      };
    };
  };
}
