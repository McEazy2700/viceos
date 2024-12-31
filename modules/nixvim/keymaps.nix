{ self, ... }: {
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
      action = "<cmd> ToggleTerm direction=float name=float <cr>";
      key = "<M-f>";
      mode = [ "n" "t" ];
      options = {
        desc = "Toggle floating term";
      };
    }
  ];
}
