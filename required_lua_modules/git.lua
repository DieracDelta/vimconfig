require('blamer').setup({
  date_format = "%m-%d-%Y %H:%M",  -- Date format
  window_width = 40,               -- Width of the blame window
  show_summary = true              -- Whether to show commit summaries
})
require('gitsigns').setup({})
require('neogit').setup({
  signs = {
    section = { "", "" },
    item = { "", "" },
    hunk = { "", "" },
  },
})

vim.api.nvim_set_keymap('n', '<leader>gs', '<cmd>lua require("neogit").open()<cr>', {})
vim.api.nvim_set_keymap('n', '<leader>gb', '<cmd>BlamerToggle<cr>', {})
vim.api.nvim_set_keymap('n', '<leader>hs', '<cmd>Gitsigns preview_hunk<cr>', {})
vim.api.nvim_set_keymap('n', '<leader>hn', '<cmd>Gitsigns next_hunk<cr>', {})
vim.api.nvim_set_keymap('n', '<leader>hp', '<cmd>Gitsigns prev_hunk<cr>', {})
