{ inputs
, pkgs
, ...
}: {
  vim.package = inputs.neovim-overlay.packages.${pkgs.system}.neovim;
  programs.nvf = {
    enable = true;
  };
}
