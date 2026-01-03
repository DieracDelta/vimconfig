local lze = require("lze")

lze.load({
  "surround-nvim",
  keys = {
    { "s", mode = "n", desc = "Surround" },
  },
  after = function()
    require('surround').setup({
      context_offset = 100,
      load_autogroups = false,
      mappings_style = "sandwich",
      map_insert_mode = true,
      quotes = {"'", '"'},
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
  end,
})

lze.load({
  "undotree",
  cmd = { "UndotreeToggle" },
  keys = {
    { "<leader>u", desc = "Undotree" },
  },
  after = function()
    vim.api.nvim_set_keymap('n', '<leader>u', '<cmd>UndotreeToggle<cr>', {})
  end,
})

lze.load({
  "colorizer",
  cmd = { "AnsiEsc" },
  keys = {
    { "<leader>ai", "<cmd>AnsiEsc<cr>", desc = "AnsiEsc" },
  },
})

