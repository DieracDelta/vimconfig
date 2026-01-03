function show_documentation()
  local filetype = vim.bo.filetype
  if vim.tbl_contains({ "vim", "help" }, filetype) then
    vim.cmd("h " .. vim.fn.expand("<cword>"))
  elseif vim.tbl_contains({ "man" }, filetype) then
    vim.cmd("Man " .. vim.fn.expand("<cword>"))
  elseif vim.fn.expand("%:t") == "Cargo.toml" then
    require("crates").show_popup()
  elseif string.match(filetype, "rust") == "rust" then
    vim.cmd.RustLsp({ "hover", "actions" })
  else
    vim.lsp.buf.hover()
  end
end

vim.fn.setenv("CARGO_TARGET_DIR", "target_dirs/nix_ra")

vim.api.nvim_set_keymap("n", "K", "<cmd>lua show_documentation()<cr>", {})
vim.api.nvim_set_keymap("n", "<leader>D", "<cmd>lua vim.lsp.buf.declaration()<cr>", {})
vim.api.nvim_set_keymap("n", "<leader>d", "<cmd>lua vim.lsp.buf.definition()<cr>", {})
vim.api.nvim_set_keymap("n", "<leader>i", "<cmd>lua vim.lsp.buf.implementation()<cr>", {})
vim.api.nvim_set_keymap("n", "<leader>S", "<cmd>lua vim.lsp.buf.signature_help()<cr>", {})
vim.api.nvim_set_keymap("n", "<leader>k", "<cmd>vim.lsp.buf.type_definition()<cr>", {})
vim.api.nvim_set_keymap("n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<cr>", {})
vim.api.nvim_set_keymap("n", "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<cr>", {})
vim.api.nvim_set_keymap("n", "<leader>r", "<cmd>lua vim.lsp.buf.references()<cr>", {})
vim.api.nvim_set_keymap("n", "<leader>e", "<cmd>lua vim.diagnostic.open_float()<cr>", {})
vim.api.nvim_set_keymap("n", "<leader>dn", "<cmd>lua vim.diagnostic.goto_next()<cr>", {})
vim.api.nvim_set_keymap("n", "<leader>dp", "<cmd>lua vim.diagnostic.goto_prev()<cr>", {})
-- <leader>f is now handled by conform lazy load

vim.g.inlay_hints_visible = true
function toggle_inlay_hints()
  if vim.g.inlay_hints_visible then
    vim.g.inlay_hints_visible = false
    vim.lsp.inlay_hint(bufnr, false)
  else
    if client.server_capabilities.inlayHintProvider then
      vim.g.inlay_hints_visible = true
      vim.lsp.inlay_hint(bufnr, true)
    else
      print("no inlay hints available")
    end
  end
end

vim.api.nvim_set_keymap("n", "<leader>rh", "<cmd>lua toggle_inlay_hints()<cr>", {})

-- Keep empty leader mappings for now if intended
vim.api.nvim_set_keymap("n", "<leader>", "<cmd><cr>", {})

require("vim._extui").enable({
  enable = true,
  msg = {
    target = "cmd",
    timeout = 4000,
  },
})

vim.opt.messagesopt = "wait:2000,history:1000"
vim.opt.shortmess:append("sIWFcC")

vim.keymap.set("n", "<leader>m", "<Cmd>messages<CR>", {
  desc = "Show message history (:messages pager)",
})