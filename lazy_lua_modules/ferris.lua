require("lze").load {
  "ferris-nvim",
  ft = {"rust"},
  after = function()
    require('ferris').setup({})
    vim.api.nvim_set_keymap('n', '<leader>rl', '<cmd>lua require("ferris.methods.view_memory_layout")()<cr>', {})
    vim.api.nvim_set_keymap('n', '<leader>rhi', '<cmd>lua require("ferris.methods.view_hir")()<cr>', {})
    vim.api.nvim_set_keymap('n', '<leader>rmi', '<cmd>lua require("ferris.methods.view_mir")()<cr>', {})
    vim.api.nvim_set_keymap('n', '<leader>rb', '<cmd>lua require("ferris.methods.rebuild_macros")()<cr>', {})
    vim.api.nvim_set_keymap('n', '<leader>rm', '<cmd>lua vim.cmd.RustLsp("expandMacro")<cr>', {})
  end,
}
