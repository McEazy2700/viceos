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
      tabstop = 4;
      shiftwidth = 4;
      softtabstop = 0;
      expandtab = true;
      smarttab = true;
    };
}
