{
  programs.nvf = {
    enable = true;
    settings = {
      vim = {
        options = {
          softtabstop = 0;
          expandtab = true;
          smarttab = true;
          autoindent = true;
          backspace = "indent,eol,start";
          backup = false;
          cmdheight = 1;
          completeopt = "menu,menuone,noselect";
          conceallevel = 0;
          cursorline = true;
          foldcolumn = "1";
          foldenable = true;
          foldlevel = 5;
          foldlevelstart = 99;
          ignorecase = true;
          laststatus = 3;
          mouse = "a";
          number = true;
          numberwidth = 4;
          pumheight = 0;
          relativenumber = true;
          shiftwidth = 2;
          tabstop = 2;
          showtabline = 1;
          signcolumn = "no";
          smartcase = true;
          termguicolors = true;
          undofile = true;
          updatetime = 100;
          timeoutlen = 300;
          lazyredraw = true;
          wrap = false;
        };
        keymaps = [
          {
            key = "<leader>e";
            mode = "n";
            silent = true;
            desc = "Open Explorer";
            action = "<cmd> NvimTreeToggle <cr>";
          }
          {
            action = "<cmd> BufferLineCycleNext <cr>";
            key = "]b";
            mode = "n";
            silent = true;
            desc = "Next Buffer";
          }
          {
            action = "<cmd> BufferLineCyclePrev <cr>";
            key = "[b";
            desc = "Previous Buffer";
            mode = "n";
            silent = true;
          }
          {
            action = "<cmd> bdelete <cr>";
            key = "<leader>x";
            desc = "Close Buffer";
            mode = "n";
            silent = true;
          }
          {
            action = "<cmd> 1ToggleTerm direction=float name=float <cr>";
            key = "<M-f>";
            mode = ["n" "t"];
            desc = "Toggle floating term";
          }
          {
            action = "<cmd> 2ToggleTerm direction=horizontal name=horizontal size=30 <cr>";
            key = "<M-h>";
            mode = ["n" "t"];
            desc = "Toggle horizontal term";
          }
          {
            action = "<cmd> 3ToggleTerm direction=vertical name=vertical size=110 <cr>";
            key = "<M-v>";
            mode = ["n" "t"];
            desc = "Toggle vertical term";
          }
          {
            action = ''"+y'';
            key = "<leader>y";
            mode = ["n" "v"];
            desc = "Yank to system clipboard";
          }
          {
            action = "<cmd> LazyGit <cr>";
            key = "<leader>lg";
            desc = "LazyGit";
            mode = "n";
            silent = true;
          }
          {
            action = "<cmd> Telescope git_files <cr>";
            key = "<leader>ff";
            desc = "Telescope find files";
            mode = "n";
            silent = true;
          }
          {
            action = "<cmd> Telescope lsp_definitions <cr>";
            key = "gd";
            desc = "Telescope lsp definitions";
            mode = "n";
            silent = true;
          }
          {
            action = "<cmd> Telescope lsp_references <cr>";
            key = "gr";
            desc = "Telescope lsp references";
            mode = "n";
            silent = true;
          }
          {
            action = "<cmd> Telescope frecency <cr>";
            key = "<leader>fr";
            desc = "Telescope find recent files";
            mode = "n";
            silent = true;
          }
          {
            action = "<cmd> Telescope live_grep <cr>";
            key = "<leader>fw";
            desc = "Telescope find word";
            mode = "n";
            silent = true;
          }
          {
            action = "<cmd> Telescope buffers <cr>";
            key = "<leader>fb";
            desc = "Telescope find open buffers";
            mode = "n";
            silent = true;
          }
          {
            action = "<cmd> Telescope oldfiles <cr>";
            key = "<leader>fo";
            desc = "Telescope find old files";
            mode = "n";
            silent = true;
          }
          {
            action = "<cmd> lua vim.lsp.buf.format() <cr>";
            key = "<leader>lf";
            desc = "Lsp Format";
            mode = "n";
            silent = true;
          }
        ];
        ui = {
          borders = {
            enable = true;
            plugins = {
              lsp-signature.enable = true;
              nvim-cmp.enable = true;
              which-key.enable = true;
            };
          };
        };

        viAlias = false;
        vimAlias = true;
        enableLuaLoader = true;
        useSystemClipboard = true;
        visuals.indent-blankline.enable = true;
        treesitter.context.enable = true;
        lsp = {
          enable = true;
          formatOnSave = true;
          lightbulb.enable = true;
          lspSignature.enable = true;
          lspconfig.enable = true;
          lspkind.enable = true;
          lsplines.enable = true;
          null-ls.enable = true;
          nvim-docs-view.enable = true;
          otter-nvim.enable = true;
          trouble.enable = true;
        };
        statusline.lualine.enable = true;
        telescope.enable = true;
        autocomplete.nvim-cmp.enable = true;
        autopairs.nvim-autopairs.enable = true;
        binds.cheatsheet.enable = true;
        binds.whichKey.enable = true;
        comments.comment-nvim.enable = true;
        dashboard.alpha.enable = true;
        debugger.nvim-dap.enable = true;
        filetree.nvimTree = {
          enable = true;
          setupOpts.update_focused_file.enable = true;
        };
        git = {
          enable = true;
          gitsigns.enable = true;
          gitsigns.codeActions.enable = true;
        };

        terminal.toggleterm.enable = true;
        terminal.toggleterm.lazygit.enable = true;
        tabline.nvimBufferline.enable = true;

        languages = {
          enableLSP = true;
          enableDAP = true;
          enableExtraDiagnostics = true;
          enableFormat = true;
          enableTreesitter = true;
          bash.enable = true;
          css.enable = true;
          nix.enable = true;
          ts.enable = true;
          python.enable = true;
          rust.enable = true;
          go.enable = true;
          sql.enable = true;
          svelte.enable = true;
          tailwind.enable = true;
        };

        theme = {
          enable = true;
          name = "tokyonight";
          style = "night";
          transparent = false;
        };
      };
    };
  };
}
