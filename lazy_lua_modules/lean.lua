require("lze").load({
  "lean.nvim",
  ft = { "lean" },
  after = function()
    require("lean").setup({
      mappings = true,
    })
    vim.lsp.enable("leanls")
  end,
})