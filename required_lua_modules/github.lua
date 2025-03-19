require('gitlinker').setup()
-- browse
vim.keymap.set(
  {"n", 'v'},
  "<leader>yg",
  "<cmd>GitLink<cr>",
  { silent = true, noremap = true, desc = "Copy git permlink to clipboard" }
)
vim.keymap.set(
  {"n", 'v'},
  "<leader>yG",
  "<cmd>GitLink!<cr>",
  { silent = true, noremap = true, desc = "Open git permlink in browser" }
)
-- blame
vim.keymap.set(
  {"n", 'v'},
  "<leader>yb",
  "<cmd>GitLink blame<cr>",
  { silent = true, noremap = true, desc = "Copy git blame link to clipboard" }
)
vim.keymap.set(
  {"n", 'v'},
  "<leader>yB",
  "<cmd>GitLink! blame<cr>",
  { silent = true, noremap = true, desc = "Open git blame link in browser" }
)

