{ pkgs
, lib
, ...
}: {
  fonts.fontconfig.enable = true;
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
        dev_py39 = "nix develop ~/.dotfile/viceos/flakes/python3.9-dev/";
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
        font-family = "Fira Code";
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
    shortcut = "Space";
    plugins = with pkgs.tmuxPlugins; [
      {
        plugin = catppuccin;
        extraConfig = ''
          set -g @catppuccin_flavour "mocha"  # Latte/frappe/macchiato/mocha
          set -g @catppuccin_window_left_separator ""
          set -g @catppuccin_window_right_separator " "
          set -g @catppuccin_window_middle_separator " █"
          set -g @catppuccin_status_modules_right "directory session date_time"
          set -g @catppuccin_status_left_separator " "
          set -g @catppuccin_status_right_separator ""

          # Override window formatting completely
          set -g @catppuccin_window_default_format "#W"
          set -g @catppuccin_window_current_format "#W"
          
          # Disable the plugin's built-in window status
          set -g @catppuccin_window_status_enable "no"
        '';
      }
    ];
    extraConfig = ''
      # True color support (critical for Neovim)
      set -ag terminal-overrides ",xterm*:RGB"

      # Vim-like pane navigation (Alt+h/j/k/l)
      bind -n M-H previous-window
      bind -n M-L next-window

      # Force all windows to show only basename regardless of focus state
      set-option -g status-interval 1
      set-option -g automatic-rename on
      set-option -g automatic-rename-format '#{b:pane_current_path}'
      
      # Explicitly set both window formats to show just the directory name
      set-window-option -g window-status-format "#[fg=colour8]#I #[fg=colour8]#{b:pane_current_path}"
      set-window-option -g window-status-current-format "#[fg=colour7]#I #[fg=colour7]#{b:pane_current_path}"
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
    python3Full
    python3Packages.pandas
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
    nodejs
    pnpm
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
