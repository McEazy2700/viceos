{
  programs.nixvim = {
    enable = false;
    imports = [ ./keymaps.nix ./colorschemes.nix ./options.nix ./plugins.nix ];
    defaultEditor = true;
  };
}
