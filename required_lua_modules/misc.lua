require('surround').setup(
{
  context_offset = 100,
  load_autogroups = false,
  mappings_style = "sandwich",
  map_insert_mode = true,
  quotes = {"'", "\""},
  brackets = {"(", "{", "["},
  space_on_closing_char = false,
  pairs = {
    nestable = {
      b = { "(", ")" },
      s = { "[", "]" },
      B = { "{", "}" },
      a = { "<", ">" },
    },
    linear = {
      q = { "'", "'" },
      t = { "`", "`" },
      d = { "\"", "\"" },
    },
  },
  prefix = "s",

})

vim.api.nvim_set_keymap('n', '<leader>u', '<cmd>UndotreeToggle<cr>', {})
vim.api.nvim_set_keymap('n', '<leader>', '<cmd><cr>', {})
vim.api.nvim_set_keymap('n', '<leader>ai', '<cmd>AnsiEsc<cr>', {}) -- ansiesc. should go in misc

require('ghostty').setup({})
