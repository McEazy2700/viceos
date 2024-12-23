local harpoon = require "harpoon"

-- REQUIRED
harpoon:setup()
-- REQUIRED
--
-- basic telescope configuration
local conf = require("telescope.config").values
local function toggle_telescope(harpoon_files)
  local file_paths = {}
  for _, item in ipairs(harpoon_files.items) do
    table.insert(file_paths, item.value)
  end

  require("telescope.pickers")
    .new({}, {
      prompt_title = "Harpoon",
      finder = require("telescope.finders").new_table {
        results = file_paths,
      },
      previewer = conf.file_previewer {},
      sorter = conf.generic_sorter {},
    })
    :find()
end

vim.keymap.set("n", "<leader>fh", function()
  toggle_telescope(harpoon:list())
end, { desc = "Find harpoon window" })

vim.keymap.set("n", "<leader>ha", function()
  harpoon:list():append()
end, { desc = "Harpoon Add" })
vim.keymap.set("n", "<leader>he", function()
  harpoon.ui:toggle_quick_menu(harpoon:list())
end, { desc = "Harpoon Explore" })

vim.keymap.set("n", "<C-h>", function()
  harpoon:list():select(1)
end)
vim.keymap.set("n", "<C-t>", function()
  harpoon:list():select(2)
end)
vim.keymap.set("n", "<C-n>", function()
  harpoon:list():select(3)
end)
vim.keymap.set("n", "<C-s>", function()
  harpoon:list():select(4)
end)

-- Toggle previous & next buffers stored within Harpoon list
vim.keymap.set("n", "<C-S-[>", function()
  harpoon:list():prev()
end, { desc = "Harpoon Previous" })
vim.keymap.set("n", "<C-S-]>", function()
  harpoon:list():next()
end, { desc = "Harpoon Next" })
