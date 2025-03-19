require("lze").load {
  "ghostty-nvim",
  event = "BufEnter */ghostty/config",
  after = function()
    require('ghostty').setup({})
  end,
}
