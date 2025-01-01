{ ... }: {
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
    shiftwidth = 4;
    tabstop = 4;
    showtabline = 1;
    signcolumn = "no";
    smartcase = true;
    termguicolors = true;
    timeoutlen = 300;
    undofile = true;
    updatetime = 300;
    wrap = true;
  };
  performance = {
    byteCompileLua.enable = true;
    combinePlugins.enable = false;
  };
  globals = {
    mapleader = " ";
    signcolumn = "yes";
  };

  editorconfig.enable = true;
  luaLoader.enable = true;
  autoCmd = [
    {
      event = [ "TextYankPost" ];
      pattern = [ "*" ];
      command = "silent! lua vim.highlight.on_yank()";
    }
    {
      event = [ "VimEnter" "BufEnter" ];
      command = "colorscheme catppuccin-mocha";
    }
    {
      event = [ "VimEnter" ];
      command = "Telescope find_files";
    }
  ];
}
