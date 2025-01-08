{ pkgs, ... }: {
  programs = {
    kitty = {
      enable = true;
      shellIntegration.enableFishIntegration = true;
      extraConfig = ''
        background_opacity 0.9
        background_blur 4
      '';
    };
    git = {
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
    fish = {
      enable = true;
      shellAliases = {
        tmux = "tmux -u";
      };
    };
  };

  programs.tmux = {
    enable = true;
    shell = "${pkgs.fish}/bin/fish";
    plugins = with pkgs; [
      tmuxPlugins.sensible
      tmuxPlugins.vim-tmux-navigator
      tmuxPlugins.catppuccin
    ];
    extraConfig = ''
      set-option -sa terminal-overrides ",xterm*:Tc"

      unbind C-b
      set -g prefix C-Space
      bind C-Space send-prefix

      bind -n M-H previous-window
      bind -n M-L next-window
    '';
  };

  programs.poetry = {
    enable = true;
  };

  programs.starship = {
    enable = true;
  };

  home.packages = with pkgs; [
    rustc
    cargo
    rustfmt
    clippy
    pipx
    python310Full
    nodejs_20
    nodePackages.npm
    nodePackages.pnpm
    pipenv
    (import ./google-cloud-cli.nix { inherit pkgs; })
    postgresql
    pgcli
  ];
}
