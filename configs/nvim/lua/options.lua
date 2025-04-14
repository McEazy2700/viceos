require "nvchad.options"

-- add yours here!

local o = vim.o
o.cursorlineopt = "both" -- to enable cursorline!
o.nu = true
o.rnu = true
o.cursorline = true
o.wrap = false
o.foldcolumn = "1"
o.foldlevel = 99
o.foldlevelstart = 99
o.foldenable = true

local lsp_utils = require "utils.lsp"

vim.g.rustaceanvim = {
  -- Plugin configuration
  tools = {},
  -- LSP configuration
  server = {
    cmd = function()
      local mason_registry = require "mason-registry"
      if mason_registry.is_installed "rust-analyzer" then
        -- This may need to be tweaked depending on the operating system.
        local ra = mason_registry.get_package "rust-analyzer"
        local ra_filename = ra:get_receipt():get().links.bin["rust-analyzer"]
        return { ("%s/%s"):format(ra:get_install_path(), ra_filename or "rust-analyzer") }
      else
        -- global installation
        return { "rust-analyzer" }
      end
    end,
    on_attach = lsp_utils.on_attach,
    default_settings = {
      -- rust-analyzer language server configuration
      ["rust-analyzer"] = {},
    },
  },
  -- DAP configuration
  dap = {},
}
