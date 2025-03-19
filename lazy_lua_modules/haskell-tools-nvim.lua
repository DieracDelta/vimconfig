require("lze").load {
  "haskell-tools",
  ft = {"haskell"},
  before = function()
  end,
  after = function()
    require('haskell-tools')
    require('telescope').load_extension('ht')
    vim.cmd("doautocmd FileType haskell")
  end,
}
