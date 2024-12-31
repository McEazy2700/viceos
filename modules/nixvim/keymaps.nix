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
      action = "<cmd> ToggleTerm direction=float name=float <cr>";
      key = "<M-f>";
      mode = [ "n" "t" ];
      options = {
        desc = "Toggle floating term";
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
  ];
}
