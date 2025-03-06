{
  programs.nixvim = {
    enable = true;
    imports = [./keymaps.nix ./colorschemes.nix ./options.nix ./plugins.nix];
    defaultEditor = true;
  };
}
