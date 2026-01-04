require("lze").load({
  "lean.nvim",
  ft = { "lean" },
  after = function()
    require("lean").setup({
      mappings = true,
    })
    vim.lsp.enable("leanls")
    vim.api.nvim_set_keymap("n", "<leader>lr", "<cmd>lua vim.lsp.buf.restart()<cr>", { noremap = true, silent = true, desc = "Lean Reload File" })
  end,
})