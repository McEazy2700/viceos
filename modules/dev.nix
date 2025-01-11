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
        dev_job = "cd ~/Documents/dev/jobs && tmux new -s Jobs";
        dev_learn = "cd ~/Documents/dev/learn && tmux new -s Learn";
        dev_mine = "cd ~/Documents/dev/mine && tmux new -s Mine";
        gio_shell = "nix develop ~/.dotfiles/nixos#gio && fish";
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

  programs.starship = {
    enable = true;
  };

  home.packages = with pkgs; [
    (import ./google-cloud-cli.nix { inherit pkgs; })
    pgcli

    # Python
    pipx
    python310Full
    python3Packages.pip
    python3Packages.poetry-core
    black
    pylint
    python3Packages.pytest
    libffi
    pipenv

    # Rust development tools
    (rust-bin.stable.latest.default.override {
      targets = [ "wasm32-unknown-unknown" ];
    })
    cargo-edit
    cargo-watch
    cargo-audit
    cargo-tauri
    gobject-introspection

    # Go development tools
    go
    gopls
    delve
    golangci-lint

    # Node.js development tools
    nodejs_20
    yarn
    nodePackages.pnpm
    nodePackages.npm
    nodePackages.typescript
    nodePackages.typescript-language-server
  ];

  home.sessionVariables = {
    GOPATH = "$HOME/go";
    CARGO_HOME = "$HOME/.cargo";
  };
}
