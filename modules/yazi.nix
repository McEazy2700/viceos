{ config, pkgs, ... }: {
  # File-manager
  programs.yazi = {
    enable = true;
    theme = {
      filetype = {
        rules = [
          # Images
          { mime = "image/*"; fg = "#94e2d5"; }

          # Media
          { mime = "{audio,video}/*"; fg = "#f9e2af"; }

          # Archives
          { mime = "application/*zip"; fg = "#f5c2e7"; }
          { mime = "application/x-{tar,bzip*,7z-compressed,xz,rar}"; fg = "#f5c2e7"; }

          # Documents
          { mime = "application/{pdf,doc,rtf}"; fg = "#a6e3a1"; }

          # Fallback
          { name = "*"; fg = "#cdd6f4"; }
          { name = "*/"; fg = "#89b4fa"; }
        ];
      };
    };
  };
}
