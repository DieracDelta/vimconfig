vim.g.blamer_enabled = 1
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
