{ ... }: {
    globals = {
      mapleader = " ";
      clipboard = {
        providers = {
          wl-copy.enable = true; # Wayland 
          xsel.enable = true; # For X11
        };
        register = "unnamedplus";
      };
      tabstop = 2;
      shiftwidth = 2;
      softtabstop = 0;
      expandtab = true;
      smarttab = true;

      # Always show the signcolumn, otherwise text would be shifted when displaying error icons
      signcolumn = "yes";
    };
    autoCmd = [
      {
        event = [ "VimEnter" ];
        callback = { __raw = "function() if vim.fn.argv(0) == '' then require('telescope.builtin').find_files() end end"; };
      }
      {
        event = [ "VimEnter" ];
	command = "colorscheme catppuccin-mocha";
      }
    ];
}
