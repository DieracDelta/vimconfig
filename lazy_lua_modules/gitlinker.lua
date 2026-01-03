local lze = require("lze")

lze.load({
  "gitlinker.nvim",
  keys = {
    { "<leader>gy", desc = "Git Linker" },
  },
  after = function()
    require("gitlinker").setup()
  end,
})
