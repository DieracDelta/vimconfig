require("lze").load({
  "gitlinker-nvim",
  on_require = { "gitlinker" },
  keys = {
    { "<leader>gy", desc = "Git Linker" },
  },
  load = function(name)
    vim.cmd("packadd " .. name)
  end,
  after = function()
    require("gitlinker").setup()
    vim.api.nvim_set_keymap("n", "<leader>gy", "<cmd>GitLink<cr>", { desc = "Yank git link" })
    vim.api.nvim_set_keymap("v", "<leader>gy", "<cmd>GitLink<cr>", { desc = "Yank git link" })
  end,
})
