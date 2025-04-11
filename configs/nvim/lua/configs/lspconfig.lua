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

local map = vim.keymap.set

local on_attach = function(_, bufnr)
  local function opts(desc)
    return { buffer = bufnr, desc = "LSP " .. desc }
  end

  map("n", "[d", function()
    vim.diagnostic.goto_prev()
    vim.diagnostic.open_float { border = "rounded", bufnr = bufnr }
  end, { desc = "Previous Diagnostic" })

  map("n", "]d", function()
    vim.diagnostic.goto_next()
    vim.diagnostic.open_float { border = "rounded", bufnr = bufnr }
  end, { desc = "Next Buffer" })

  map("n", "gD", vim.lsp.buf.declaration, opts "Go to declaration")
  map("n", "gd", vim.lsp.buf.definition, opts "Go to definition")
  map("n", "gi", "<cmd> Telescope lsp_implementations <CR>", opts "Go to implementation")
  map("n", "<leader>gl", "<cmd> Telescope git_commits <CR>", opts "   git log (commits)")
  map("n", "<leader>gs", "<cmd> Telescope git_status <CR>", opts "  git status")
  map("n", "gr", "<cmd> Telescope lsp_references <CR>", opts "lsp references")
  map("n", "<leader>lS", "<cmd> Telescope lsp_dynamic_workspace_symbols <CR>", opts "lsp dynamic workspace symbols")
  map("n", "<leader>lj", "<cmd> Telescope lsp_document_symbols <CR>", opts "lsp document symbols")
  map("n", ",S", "<cmd> Telescope lsp_dynamic_workspace_symbols <CR>", opts "lsp dynamic workspace symbols")
  map("n", ",s", "<cmd> Telescope lsp_document_symbols <CR>", opts "lsp document symbols")
  map("n", "<leader>D", "<cmd> Telescope lsp_type_definitions <CR>", opts "Go to type definition")

  map("n", "<leader>sh", vim.lsp.buf.signature_help, opts "Show signature help")
  map("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, opts "Add workspace folder")
  map("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, opts "Remove workspace folder")

  map("n", "<leader>lr", function()
    require("nvchad_ui.renamer").open()
  end, opts "Lsp Rename Symbol")
  map("n", "<leader>lf", "<cmd>lua require('conform').format()<cr>", opts "Format")
  map({ "n", "v" }, "<leader>la", vim.lsp.buf.code_action, opts "Code action")

  map("n", "<leader>wl", function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, opts "List workspace folders")
end

local capabilities = nvlsp.capabilities

capabilities.textDocument.foldingRange = {
  dynamicRegistration = false,
  lineFoldingOnly = true,
}

-- lsps with default config
for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = on_attach,
    on_init = nvlsp.on_init,
    capabilities = capabilities,
  }
end

vim.g.rustaceanvim = {
  -- LSP configuration
  server = {
    on_attach = on_attach,
  },
}
