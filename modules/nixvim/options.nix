{...}: {
  clipboard = {
    providers = {
      wl-copy.enable = true; # Wayland
    };
    register = "unnamedplus";
  };
  opts = {
    softtabstop = 0;
    expandtab = true;
    smarttab = true;
    autoindent = true;
    backspace = "indent,eol,start";
    backup = false;
    cmdheight = 1;
    completeopt = "menu,menuone,noselect";
    conceallevel = 0;
    cursorline = true;
    foldcolumn = "1";
    foldenable = true;
    foldlevel = 5;
    foldlevelstart = 99;
    ignorecase = true;
    laststatus = 3;
    mouse = "a";
    number = true;
    numberwidth = 4;
    pumheight = 0;
    relativenumber = true;
    shiftwidth = 2;
    tabstop = 2;
    showtabline = 1;
    signcolumn = "no";
    smartcase = true;
    termguicolors = true;
    undofile = true;
    updatetime = 100;
    timeoutlen = 300;
    lazyredraw = true; # Don't redraw while executing macros
    wrap = false;
  };
  performance = {
    byteCompileLua.enable = true;
    combinePlugins.enable = true;
  };
  globals = {
    mapleader = " ";
    transparent_enabled = false;
    loaded_python_provider = 0;
    loaded_ruby_provider = 0;
    loaded_node_provider = 0;
    loaded_perl_provider = 0;
  };

  editorconfig.enable = true;
  luaLoader.enable = true;
  autoCmd = [
    {
      event = ["TextYankPost"];
      pattern = ["*"];
      command = "silent! lua vim.highlight.on_yank()";
    }
    {
      event = ["VimEnter"];
      command = "colorscheme tokyonight";
    }
    {
      event = ["VimEnter"];
      callback = {
        __raw = ''
          function()
              vim.api.nvim_set_hl(0, "@ibl.indent.char.1", { fg = "#444444" })  -- Using a lighter gray
          end
        '';
      };
    }
  ];
}
