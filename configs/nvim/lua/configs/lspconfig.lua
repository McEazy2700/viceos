-- load defaults i.e lua_lsp
require("nvchad.configs.lspconfig").defaults()

local lspconfig = require "lspconfig"

-- EXAMPLE
local servers = {
  "html",
  "cssls",
  "clangd",
  "svelte",
  "eslint",
  "rnix",
  "pyright",
  "emmet_ls",
  "dockerls",
  "ts_ls",
  -- "solidity_ls",
  "solidity_ls_nomicfoundation",
  "tailwindcss",
  "emmet_language_server",
  "docker_compose_language_service",
}
local nvlsp = require "nvchad.configs.lspconfig"

local capabilities = nvlsp.capabilities
local lsp_utils = require "utils.lsp"

capabilities.textDocument.foldingRange = {
  dynamicRegistration = false,
  lineFoldingOnly = true,
}

-- lsps with default config
for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = lsp_utils.on_attach,
    on_init = nvlsp.on_init,
    capabilities = capabilities,
  }
end
