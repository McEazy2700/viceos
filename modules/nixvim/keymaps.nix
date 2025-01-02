{ ... }: {
  keymaps = [
    {
      action = "<cmd> Neotree toggle <cr>";
      key = "<leader>e";
      options = {
        desc = "Toggle Explorer";
      };
    }
    {
      action = "<cmd> BufferLineCycleNext <cr>";
      key = "]b";
      options = {
        desc = "Next Buffer";
      };
    }
    {
      action = "<cmd> BufferLineCyclePrev <cr>";
      key = "[b";
      options = {
        desc = "Previous Buffer";
      };
    }
    {
      action = "<cmd> bdelete <cr>";
      key = "<leader>x";
      options = {
        desc = "Close Buffer";
      };
    }
    {
      action = "<cmd> 1ToggleTerm direction=float name=float <cr>";
      key = "<M-f>";
      mode = [ "n" "t" ];
      options = {
        desc = "Toggle floating term";
      };
    }
    {
      action = "<cmd> 2ToggleTerm direction=horizontal name=horizontal size=30 <cr>";
      key = "<M-h>";
      mode = [ "n" "t" ];
      options = {
        desc = "Toggle horizontal term";
      };
    }
    {
      action = "<cmd> 3ToggleTerm direction=vertical name=vertical size=110 <cr>";
      key = "<M-v>";
      mode = [ "n" "t" ];
      options = {
        desc = "Toggle vertical term";
      };
    }
    {
      action = ''"+y'';
      key = "<leader>y";
      mode = [ "n" "v" ];
      options = {
        desc = "Yank to system clipboard";
      };
    }
    {
      action = "<cmd> LazyGit <cr>";
      key = "<leader>lg";
      options = {
        desc = "LazyGit";
      };
    }
    {
      action = "<cmd> Telescope git_files <cr>";
      key = "<leader>ff";
      options = {
        desc = "Telescope find files";
      };
    }
    {
      action = "<cmd> Telescope lsp_definitions <cr>";
      key = "gd";
      options = {
        desc = "Telescope lsp definitions";
      };
    }
    {
      action = "<cmd> Telescope lsp_references <cr>";
      key = "gr";
      options = {
        desc = "Telescope lsp references";
      };
    }
    {
      action = "<cmd> Telescope frecency <cr>";
      key = "<leader>fr";
      options = {
        desc = "Telescope find recent files";
      };
    }
    {
      action = "<cmd> Telescope live_grep <cr>";
      key = "<leader>fw";
      options = {
        desc = "Telescope find word";
      };
    }
    {
      action = "<cmd> Telescope buffers <cr>";
      key = "<leader>fb";
      options = {
        desc = "Telescope find open buffers";
      };
    }
    {
      action = "<cmd> Telescope oldfiles <cr>";
      key = "<leader>fo";
      options = {
        desc = "Telescope find old files";
      };
    }
    {
      action = "<cmd> lua vim.lsp.buf.format() <cr>";
      key = "<leader>lf";
      options = {
        desc = "Lsp Format";
      };
    }
    {
      action = "<cmd> Lspsaga rename <cr>";
      key = "<leader>lr";
      options = {
        desc = "Lsp Rename";
      };
    }
    {
      action = "<cmd> Lspsaga hover_doc <cr>";
      key = "K";
      options = {
        desc = "Hover documentation";
      };
    }
    {
      action = "<cmd> Lspsaga code_action <cr>";
      key = "<leader>la";
      options = {
        desc = "Code Action";
      };
    }
    {
      key = "[d";
      action = "<cmd> Lspsaga diagnostic_jump_prev <cr>";
      options = {
        desc = "Previous Diagnostic";
      };
    }
    {
      key = "]d";
      action = "<cmd> Lspsaga diagnostic_jump_next <cr>";
      options = {
        desc = "Next Diagnostic";
      };
    }
  ];
}
