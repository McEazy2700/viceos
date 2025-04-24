{ pkgs, ... }: {
  stylix = {
    # base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-macchiato.yaml";
    enable = true;
    autoEnable = true;
    image = ../Wallpapers/chill-luffy.png;
    polarity = "dark";
    cursor.package = pkgs.bibata-cursors;
    cursor.name = "Bibata-Modern-Ice";
    targets.neovim.enable = false;
    fonts = {
      monospace = {
        package = pkgs.nerd-fonts.fira-code;
        name = "Fira Code";
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
