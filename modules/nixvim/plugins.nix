{ ... }: {
  plugins = {
    lspsaga.enable = true;
    transparent.enable = true;
    telescope = {
      enable = true;
      highlightTheme = "catppuccin-mocha";
      settings = {
        defaults = {
          file_ignore_patterns = [
            "^.git/"
            "^.mypy_cache/"
            "^__pycache__/"
            "^output/"
            "^data/"
            "%.ipynb"
            "%.lock"
          ];
          layout_config = {
            prompt_position = "top";
          };
          selection_caret = "  ";
          set_env = {
            COLORTERM = "truecolor";
          };
          sorting_strategy = "ascending";
        };
      };
      extensions = {
        frecency.enable = true;
        file-browser.enable = true;
        media-files = {
          enable = true;
          settings = {
            filetypes = [
              "png"
              "jpg"
              "gif"
              "mp4"
              "webm"
              "pdf"
            ];
            find_cmd = "rg";
          };
          dependencies = {
            chafa.enable = true;
            epub-thumbnailer.enable = true;
            ffmpegthumbnailer.enable = true;
            imageMagick.enable = true;
            pdftoppm.enable = true;
          };
        };
      };
    };
    treesitter = {
      enable = true;
      settings = {
        auto_install = true;
        indent.enable = true;
        highlight.enable = true;
      };
    };
    ts-autotag.enable = true;
    which-key = {
      enable = true;
      settings = {
        win = {
          border = "rounded";
        };
      };
    };
    nvim-autopairs.enable = true;
    lsp-format.enable = true;
    rustaceanvim.enable = true;
    lsp = {
      enable = true;
      inlayHints = true;
      servers = {
        eslint.enable = true;
        emmet_ls.enable = true;
        nixd.enable = true;
        basedpyright.enable = true;
        golangci_lint_ls.enable = true;
        gopls.enable = true;
        tailwindcss.enable = true;
        ts_ls.enable = true;
        cssls.enable = true;
        svelte.enable = true;
        dockerls.enable = true;
        emmet_language_server.enable = true;
        docker_compose_language_service.enable = true;
      };
    };
    indent-blankline = {
      enable = true;
      settings = {
        whitespace.remove_blankline_trail = false;
        indent = {
          char = "▎"; # "│" or "▎"
          tab_char = "│";
          smart_indent_cap = true;
        };
        scope = {
          enabled = false;
        };
        exclude = {
          buftypes = [ "terminal" "nofile" ];
          filetypes = [
            "help"
            "alpha"
            "dashboard"
            "NvimTree"
            "Trouble"
            "trouble"
            "lazy"
            "mason"
            "notify"
            "toggleterm"
            "lazyterm"
          ];
        };
      };
    };
    snacks = {
      enable = true;

      settings = {
        bigfile.enable = true;
        dashboard.enable = true;
        indent.enable = true;
        input.enable = true;
        notifier.enable = true;
        quickfile.enable = true;
        scroll.enable = true;
        statuscolumn.enable = true;
        words.enable = true;
        gitbrowse.enabled = true;
        lazygit.enabled = true;
        profiler.enabled = true;
      };
    };
  };
  plugins.none-ls = {
    enable = true;
    enableLspFormat = true;
    settings = {
      border = "rounded"; # Rounded borders for :NullLsInfo window
      cmd = [ "nvim" ];
    };
    sources = {
      code_actions = {
        statix.enable = true;
      };
      diagnostics = {
        statix.enable = true;
        # deadnix.enable = true;
        checkstyle.enable = true;
      };
      formatting = {
        alejandra.enable = true;
        stylua.enable = true;
        shfmt.enable = true;
        nixpkgs_fmt.enable = true;
        prettier = {
          enable = true;
          disableTsServerFormatter = true;
        };
        black.enable = true;
      };

      completion = {
        # luasnip.enable = true;
        # vsnip.enable = true;
        # spell.enable = true;
        # tags.enable = true;
      };
    };
  };
  plugins.lazygit.enable = true;
  plugins.lint = {
    enable = false;
    lintersByFt = {
      text = [ "vale" ];
      json = [ "jsonlint" ];
      markdown = [ "vale" ];
      rst = [ "vale" ];
      ruby = [ "ruby" ];
      janet = [ "janet" ];
      inko = [ "inko" ];
      clojure = [ "clj-kondo" ];
      dockerfile = [ "hadolint" ];
      terraform = [ "tflint" ];
    };
  };
  plugins.trouble.enable = true;
  plugins.friendly-snippets.enable = true;
  plugins.luasnip = {
    enable = true;
    settings = {
      enable_autosnippets = true;
      store_selection_keys = "<Tab>";
    };
  };
  plugins.undotree.enable = true;
  plugins.toggleterm = {
    enable = true;
    settings = {
      direction = "float";
      float_opts = {
        border = "curved";
        height = ''
          function()
                return math.floor(vim.o.lines * 0.8)
              end
        '';
        width = ''
          function()
                return math.floor(vim.o.columns * 0.9)
              end
        '';
      };
    };
  };
  # Even more snippets
  plugins.nvim-snippets = {
    enable = false;
    settings = {
      create_autocmd = true;
      create_cmp_source = true;
      extended_filetypes = {
        typescript = [
          "javascript"
        ];
      };
      friendly_snippets = true;
    };
  };
  plugins.bufferline = {
    enable = true;
    settings = {
      options = {
        indicator = {
          icon = "▎ ";
          style = "icon";
        };
        diagnostics = "nvim_lsp";
        offsets = [
          {
            filetype = "NvimTree";
            highlight = "Directory";
            text = "File Explorer";
            text_align = "center";
          }
        ];
      };
    };
  };
  plugins.web-devicons.enable = true;
  plugins.nvim-tree = {
    enable = true;
    hijackCursor = true;
    openOnSetup = true;
    updateFocusedFile.enable = true;
  };
  plugins.lualine = {
    enable = true;
    settings = {
      options = {
        component_separators = "";
        section_separators = {
          left = "";
          right = "";
        };
      };
    };
  };

  plugins.cmp = {
    enable = true;
    settings = {
      completion = {
        completeopt = "menu,menuone,noinsert";
      };
      autoEnableSources = true;
      experimental = { ghost_text = true; };
      performance = {
        debounce = 30;
        fetchingTimeout = 200;
        maxViewEntries = 30;
      };
      snippet = {
        expand = ''
          function(args)
            require('luasnip').lsp_expand(args.body)
          end
        '';
      };
      formatting = { fields = [ "kind" "abbr" "menu" ]; };
      sources = [
        { name = "nvim_lsp"; }
        { name = "emoji"; }
        {
          name = "buffer"; # text within current buffer
          option.get_bufnrs.__raw = "vim.api.nvim_list_bufs";
          keywordLength = 3;
        }
        # { name = "copilot"; } # enable/disable copilot
        {
          name = "path"; # file system paths
          keywordLength = 3;
        }
        {
          name = "luasnip"; # snippets
          keywordLength = 3;
        }
      ];

      window = {
        completion = { border = "rounded"; };
        documentation = { border = "rounded"; };
      };

      mapping = {
        "<Tab>" = "cmp.mapping(cmp.mapping.select_next_item(), {'i', 's'})";
        "<S-Tab>" = "cmp.mapping(cmp.mapping.select_prev_item(), {'i', 's'})";
        "<C-Space>" = "cmp.mapping.complete()";
        "<CR>" = "cmp.mapping.confirm({ select = true })";
        "<S-CR>" = "cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = true })";
      };
    };
  };
}
