require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("n", "<leader>e", "<cmd> NvimTreeToggle <cr>", { desc = "Toggle Explorer" })
map("n", "[b", [[<cmd>lua require("nvchad.tabufline").prev() <cr>]], { desc = "Previous Buffer" })
map("n", "]b", [[<cmd>lua require("nvchad.tabufline").next() <cr>]], { desc = "Next Buffer" })
map("n", "<leader>x", [[<cmd>lua require("nvchad.tabufline").close_buffer() <cr>]], { desc = "Delete Buffer" })
map("n", "<leader>tt", [[:lua require("base46").toggle_transparency() <cr>]], { desc = "Toggle transparency" })
map("n", "<leader>cc", "<cmd>ChatGPT<cr>", { desc = "Copilot Chat" })
map("n", "<leader>ce", "<cmd>ChatGPTEditWithInstruction<cr>", { desc = "Copilot Edit" })
map("n", "<leader>ci", "<cmd>ChatGPTActAs<cr>", { desc = "Copilot Inpersonate" })
map("n", "<M-f>", [[<cmd> lua require("nvterm.terminal").toggle 'float'<cr>]], { desc = "Toggle Floating Terminal" })
map(
  "n",
  "<M-h>",
  [[<cmd> lua require("nvterm.terminal").toggle 'horizontal'<cr>]],
  { desc = "Toggle Horizontal Terminal" }
)
map("n", "<M-v>", [[<cmd> lua require("nvterm.terminal").toggle 'vertical'<cr>]], { desc = "Toggle Vertical Terminal" })

map("i", "jk", "<esc>", { desc = "Normal mode" })

map("v", ">", ">gv", { desc = "indent" })
map("v", "<leader>cx", "<cmd>ChatGPTRun explain_code<CR>", { desc = "Copilot Explain Code" })

map("t", "<esc>", [[<C-\><C-n>]], { desc = "Normal mode" })
map("t", "jk", [[<C-\><C-n>]], { desc = "Normal mode" })
map("t", "<C-h>", [[<Cmd>wincmd h<CR>]], { desc = "left window" })
map("t", "<C-j>", [[<Cmd>wincmd j<CR>]], { desc = "bottom window" })
map("t", "<C-k>", [[<Cmd>wincmd k<CR>]], { desc = "right window" })
map("t", "<C-l>", [[<Cmd>wincmd l<CR>]], { desc = "top window" })
map("t", "<M-f>", [[<cmd> lua require("nvterm.terminal").toggle 'float'<cr>]], { desc = "Toggle Floating Terminal" })
map(
  "t",
  "<M-h>",
  [[<cmd> lua require("nvterm.terminal").toggle 'horizontal'<cr>]],
  { desc = "Toggle Horizontal Terminal" }
)
map("t", "<M-v>", [[<cmd> lua require("nvterm.terminal").toggle 'vertical'<cr>]], { desc = "Toggle Vertical Terminal" })

map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>", { desc = "Save" })
