{
  programs.nixvim = {
    enable = true;
    imports = [ ./keymaps.nix ./colorschemes.nix ];
    defaultEditor = true;
    globals = {
      mapleader = " ";
      colorscheme = "catppuccin-mocha";
      clipboard = {
        providers = {
          wl-copy.enable = true; # Wayland 
          xsel.enable = true; # For X11
        };
        register = "unnamedplus";
      };
    };
    opts = {
      cursorlineopt = "both";
      nu = true;
      rnu = true;
      cursorline = true;
      wrap = false;
    };
    plugins.undotree = {
      enable = true;
    };
    plugins.toggleterm = {
      enable = true;
      settings = {
        direction = "float";
        float_opts = {
          border = "curved";
          height = ''
            function()
                  return math.floor(vim.o.lines * 0.8)
                end
          '';
          width = ''
            function()
                  return math.floor(vim.o.columns * 0.9)
                end
          '';
        };
      };
    };
    plugins.bufferline = {
      enable = true;
      settings = {
        options = {
          diagnostics = "nvim_lsp";
          separator_style = "slant";
          indicator.style = "underline";
          offsets = [
            {
              filetype = "neo-tree";
              highlight = "Directory";
              text = "File Explorer";
              text_align = "center";
            }
          ];
        };
      };
    };
    plugins.web-devicons.enable = true;
    plugins.neo-tree = {
      enable = true;
      autoCleanAfterSessionRestore = true;
      closeIfLastWindow = true;
      popupBorderStyle = "rounded";
    };
    plugins.lualine = {
      enable = true;
      settings = {
        options = {
          component_separators = "";
          section_separators = { left = ""; right = ""; };
        };
      };
    };
    plugins.alpha = {
      enable = true;
      layout =
        [
          {
            type = "padding";
            val = 10;
          }
          {
            opts = {
              hl = "Type";
              position = "center";
            };
            type = "text";
            val = [
              "███╗   ██╗██╗██╗  ██╗██╗   ██╗██╗███╗   ███╗"
              "████╗  ██║██║╚██╗██╔╝██║   ██║██║████╗ ████║"
              "██╔██╗ ██║██║ ╚███╔╝ ██║   ██║██║██╔████╔██║"
              "██║╚██╗██║██║ ██╔██╗ ╚██╗ ██╔╝██║██║╚██╔╝██║"
              "██║ ╚████║██║██╔╝ ██╗ ╚████╔╝ ██║██║ ╚═╝ ██║"
              "╚═╝  ╚═══╝╚═╝╚═╝  ╚═╝  ╚═══╝  ╚═╝╚═╝     ╚═╝"
            ];
          }
          {
            type = "padding";
            val = 10;
          }
        ];
    };
  };
}
