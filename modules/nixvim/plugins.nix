{...}: {
    plugins.telescope = {
      enable = true;
      highlightTheme = "catppuccin-mocha";
    };
    plugins.treesitter.enable = true;
    plugins.ts-autotag.enable = true;
    plugins.nvim-autopairs.enable = true;
    plugins.lsp = {
      enable = true;
      servers = {
        eslint.enable = true;
        emmet_ls.enable = true;
        nixd.enable = true;
        pyright.enable = true;
        tailwindcss.enable = true;
        ts_ls.enable = true;
        cssls.enable = true;
        svelte.enable = true;
        dockerls.enable = true;
        emmet_language_server.enable = true;
        docker_compose_language_service.enable = true;
      };
    };
    plugins.rustaceanvim.enable = true;
    plugins.cmp = {
      autoEnableSources = true;
      settings = {
        sources = [
          { name = "nvim_lsp"; }
          { name = "luasnip"; }
          { name = "path"; }
          { name = "buffer"; }
        ];
        mapping = {
          __raw = ''
            cmp.mapping.preset.insert({
              ['<C-b>'] = cmp.mapping.scroll_docs(-4),
              ['<C-f>'] = cmp.mapping.scroll_docs(4),
              ['<C-Space>'] = cmp.mapping.complete(),
              ['<C-e>'] = cmp.mapping.abort(),
              ['<CR>'] = cmp.mapping.confirm({ select = true }),
            })
          '';
        };
        snippet = {
          expand = "function(args) require('luasnip').lsp_expand(args.body) end";
        };
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
    plugins.bufferline = {
      enable = true;
      settings = {
        options = {
          diagnostics = "nvim_lsp";
          indicator.style = "underline";
          offsets = [
            {
              filetype = "neo-tree";
              highlight = "Directory";
              text = "File Explorer";
              text_align = "center";
            }
          ];
        };
      };
    };
    plugins.web-devicons.enable = true;
    plugins.neo-tree = {
      enable = true;
      autoCleanAfterSessionRestore = true;
      closeIfLastWindow = true;
      popupBorderStyle = "rounded";
    };
    plugins.lualine = {
      enable = true;
      settings = {
        options = {
          component_separators = "";
          section_separators = { left = ""; right = ""; };
        };
      };
    };
}
