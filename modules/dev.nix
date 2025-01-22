{ pkgs
, lib
, ...
}: {
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
    ghostty = {
      enable = true;
      settings = {
        background-blur-radius = 20;
        theme = "dark:catppuccin-mocha,light:catppuccin-latte";
        window-theme = "dark";
        background-opacity = 0.8;
        minimum-contrast = 1.1;
        window-decoration = false;
        confirm-close-surface = false;
        font-family = "Iosevka Nerd Font";
      };
    };
    helix = {
      enable = true;
      settings = {
        theme = lib.mkForce "ayu_dark";
        editor = {
          line-number = "relative";
          bufferline = "multiple";
        };
        keys.normal = {
          esc = [ "collapse_selection" "keep_primary_selection" ];
          "[" = {
            b = [ ":buffer-previous" ];
          };
          "]" = {
            b = [ ":buffer-next" ];
          };
        };
      };
      languages = {
        language-server = {
          pylsp = {
            config = {
              documentFormatting = true;
              pylsp = {
                plugins = {
                  black.enabled = true;
                  pyls_mypy.enabled = true;
                  rope.enabled = true;
                  rope_autoimport.enabled = true;
                };
              };
            };
          };
        };
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
    slack
    pgcli
    nixd

    # Python
    pipx
    python310Full
    python3Packages.pip
    python3Packages.poetry-core
    python3Packages.python-lsp-server
    python3Packages.pylsp-mypy
    python3Packages.pylsp-rope
    python3Packages.rope
    pyenv
    black
    pylint
    python3Packages.pytest
    libffi
    postman

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
