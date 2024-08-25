require("telescope").setup {
  defaults = {
    file_ignore_patterns = { "node_modules", "target", "target_dirs" },
    prompt_prefix = "   ",
    selection_caret = "  ",
    entry_prefix = "  ",
    borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
    vimgrep_arguments = {
      "rg",
      "--color=never",
      "--no-heading",
      "--with-filename",
      "--line-number",
      "--column",
      "--smart-case",
    },
  },
  extensions = {
    ["ui-select"] = {
      require("telescope.themes").get_dropdown {
        -- even more opts
      }
    }
  }
}
require("telescope").load_extension("file_browser")
require("telescope").load_extension("ui-select")

vim.api.nvim_set_keymap('n', '<leader>bb', '<cmd>Telescope buffers<cr>', {})
vim.api.nvim_set_keymap('n', '<leader>fb', '<cmd>Telescope file_browser<cr>', {})
vim.api.nvim_set_keymap('n', '<leader>gg', '<cmd>Telescope live_grep<cr>', {})
vim.api.nvim_set_keymap('n', '<leader><leader>', '<cmd>Telescope find_files<cr>', {})
vim.api.nvim_set_keymap('n', '<leader>gf', '<cmd>require("telescope.builtins").live_grep {default_text="function"}<cr>', {})
vim.api.nvim_set_keymap('n', '<leader>l', '<cmd>Telescope resume<cr>', {})
vim.api.nvim_set_keymap('n', '<leader>', '<cmd><cr>', {})
vim.api.nvim_set_keymap('n', '<leader>', '<cmd><cr>', {})

vim.api.nvim_set_keymap('n', '<leader>z', '<cmd>lua require("yazi").yazi()<cr>', {})
