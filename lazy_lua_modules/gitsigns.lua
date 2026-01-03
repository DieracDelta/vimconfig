require("lze").load({
  "gitsigns.nvim",
  event = { "BufReadPre", "BufNewFile" },
  keys = {
    { "<leader>hs", desc = "Preview Hunk" },
    { "<leader>hn", desc = "Next Hunk" },
    { "<leader>hp", desc = "Prev Hunk" },
  },
  after = function()
    require('gitsigns').setup({})
    vim.api.nvim_set_keymap('n', '<leader>hs', '<cmd>Gitsigns preview_hunk<cr>', {})
    vim.api.nvim_set_keymap('n', '<leader>hn', '<cmd>Gitsigns next_hunk<cr>', {})
    vim.api.nvim_set_keymap('n', '<leader>hp', '<cmd>Gitsigns prev_hunk<cr>', {})
  end,
})
