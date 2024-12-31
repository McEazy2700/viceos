{
  programs.nixvim = {
    enable = true;
    imports = [ ./keymaps.nix ./colorschemes.nix ./options.nix ./plugins.nix ];
    defaultEditor = true;
    opts = {
      cursorlineopt = "both";
      nu = true;
      rnu = true;
      cursorline = true;
      wrap = false;
    };
  };
}
