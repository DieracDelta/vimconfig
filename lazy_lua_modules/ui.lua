local lze = require("lze")

-- Existing plugins...
lze.load({
  "colorful-winsep-nvim",
  event = { "WinNew" },
  after = function()
    require("colorful-winsep").setup({ only_line_seq = false })
  end,
})

lze.load({
  "fidget",
  event = { "LspAttach" },
  after = function()
    require("fidget").setup({})
  end,
})

lze.load({
  "trouble.nvim",
  cmd = { "Trouble" },
  event = { "LspAttach" },
  keys = {
    { "<leader>t", desc = "Trouble" },
  },
  after = function()
    require("trouble").setup({})
    vim.api.nvim_set_keymap("n", "<leader>t", "<cmd>Trouble<cr>", {})
  end,
})

lze.load({
  "symbols-nvim",
  keys = {
    { "<leader>s", desc = "Symbols" },
  },
  after = function()
    local r = require("symbols.recipes")
    require("symbols").setup(r.DefaultFilters, r.AsciiSymbols, {
      sidebar = { hide_cursor = false },
      provider = { lsp = { timeout_ms = 10000 } },
    })
    vim.keymap.set("n", "<leader>s", "<cmd> SymbolsToggle<CR>")
  end,
})

lze.load({
  "node-type-nvim",
  event = { "CursorHold" },
  after = function()
    require("node-type").setup({})
  end,
})

lze.load({
  "floating-input",
  after = function()
    require("floating-input").setup({})
  end,
})

lze.load({
  "dressing.nvim",
  event = { "VimEnter" },
  after = function()
    require("dressing").setup({})
  end,
})
