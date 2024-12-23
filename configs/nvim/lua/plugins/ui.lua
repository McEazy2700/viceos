return {
  {
    "echasnovski/mini.indentscope",
    init = function()
      vim.api.nvim_create_autocmd("FileType", {
        pattern = { "help", "alpha", "dashboard", "neo-tree", "Trouble", "lazy", "mason", "nvdash", "nvcheatsheet" },
        callback = function()
          vim.b.miniindentscope_disable = true
        end,
      })
    end,
  },
  {
    "kingavatar/nvchad-ui.nvim",
    branch = "v3.0",
    lazy = false,
    config = function()
      require("nvchad_ui").setup {
        lazyVim = true,
        -- theme_toggle = { "tokyonight", "rose-pine" },
        nvdash = { load_on_startup = true },
      }
    end,
  },
}
