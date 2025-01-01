{ ... }: {
  colorschemes = {
    catppuccin = {
      enable = true;
      settings = {
        custom_highlights = ''
          function(highlights)
            return {
                CursorLineNr = { fg = highlights.peach, style = { "bold" } },
                SignColumn = { bg = "NONE" },
            }
          end
        '';
        transparent_background = true;
      };
    };
  };
}
