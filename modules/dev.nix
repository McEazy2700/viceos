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
    vscode.enable = true;
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

  nixpkgs.overlays = [
    (final: prev: {
      # Create a non-conflicting Python 2 package
      python2NonConflicting = prev.stdenv.mkDerivation {
        name = "python2-non-conflicting-${prev.python27.version}";

        # Don't build from source, just modify the existing package
        phases = [ "installPhase" ];

        nativeBuildInputs = [ prev.makeWrapper ];

        installPhase = ''
          # Create output directories
          mkdir -p $out/bin

          # Copy Python 2 with a new name to avoid conflicts
          cp -L ${prev.python27}/bin/python2* $out/bin/ 2>/dev/null || true
          cp -L ${prev.python27}/bin/python $out/bin/python2 2>/dev/null || true

          # Create a lib directory for Python modules
          mkdir -p $out/lib
          cp -r ${prev.python27}/lib/python* $out/lib/ 2>/dev/null || true

          # Create an include directory for development
          mkdir -p $out/include
          cp -r ${prev.python27}/include/python* $out/include/ 2>/dev/null || true

          # Copy other Python 2-specific binaries that won't conflict
          # Explicitly avoid copying the known conflicting ones like 2to3
          for bin in ${prev.python27}/bin/*; do
            binName=$(basename "$bin")
            # Skip conflicting binaries
            if [[ "$binName" != "2to3" && "$binName" != "idle" &&
                  "$binName" != "pydoc" && "$binName" != "python" &&
                  "$binName" != "python-config" ]]; then
              # Only copy if it doesn't exist yet and contains "2" in the name
              if [[ "$binName" == *"2"* && ! -e "$out/bin/$binName" ]]; then
                cp -L "$bin" "$out/bin/$binName"
              fi
            fi
          done
        '';
      };
    })
  ];

  home.packages = with pkgs; [
    (import ./google-cloud-cli.nix { inherit pkgs; })
    slack
    pgcli
    nixd
    bun
    # google-cloud-cli

    # Python
    pipx
    python310Full
    python310Packages.pandas
    python3Packages.pip
    python3Packages.poetry-core
    python3Packages.python-lsp-server
    python3Packages.pylsp-mypy
    python3Packages.pylsp-rope
    python3Packages.rope
    python2NonConflicting
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
    go-migrate

    # Node.js development tools
    nodejs_20
    yarn
    nodePackages.pnpm
    nodePackages.npm
    nodePackages.typescript
    nodePackages.typescript-language-server
    bash
  ];

  home.sessionVariables = {
    GOPATH = "$HOME/go";
    CARGO_HOME = "$HOME/.cargo";
  };
}
