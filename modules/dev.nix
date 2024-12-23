{ config, pkgs, ... }:
{
  home.file = {
    ".config/nvim".source = ../configs/nvim;
  };

  programs.neovim = {
    enable = true;
    defaultEditor = true;
    plugins = with pkgs.vimPlugins; [
      lazy-nvim
    ];
  };
  programs.kitty = {
    enable = true;
    shellIntegration.enableFishIntegration = true;
  };
  programs.git = {
    enable = true;
    userName = "McEazy2700";
    userEmail = "codeepoch@gmail.com";
    extraConfig.init.defaultBranch = "main";
    aliases = {
      st = "status";
      ci = "commit";
      co = "checkout";
      br = "branch";
      unstage = "reset HEAD --";
      last = "log -1 HEAD";
    };
  };
  programs.tmux = {
    enable = true;
    shell = "${pkgs.fish}/bin/fish";
  };
  home.packages = with pkgs; [
    rustc
    cargo
    rustfmt
    rust-analyzer
    clippy
    python312Full
    nodejs_20
    nodePackages.npm
    nodePackages.pnpm
  ];
}
