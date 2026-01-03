local cmp = require("cmp")
local mappings = {
  ["<C-n>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
  ["<C-p>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
  ["<C-f>"] = cmp.mapping.scroll_docs(4),
  ["<C-d>"] = cmp.mapping.scroll_docs(-4),
  ["<CR>"] = cmp.mapping.confirm({ select = false }),
  ["<C-e>"] = cmp.mapping.abort(),
}

cmp.setup({
  mapping = mappings,
  sources = cmp.config.sources({
    { name = "nvim_lsp" },
    { name = "path" },
  }, {
    { name = "buffer" },
  }),
})

cmp.setup.cmdline(":", {
  mapping = cmp.mapping.preset.cmdline({
    ["<C-n>"] = { c = cmp.mapping.select_next_item() },
    ["<C-p>"] = { c = cmp.mapping.select_prev_item() },
    ["<CR>"] = { c = cmp.mapping.confirm({ select = false }) },
  }),
  sources = {
    { name = "path" },
    { name = "cmdline" },
  },
})

cmp.setup.cmdline({ "/", "?" }, {
  mapping = cmp.mapping.preset.cmdline({
    ["<C-n>"] = { c = cmp.mapping.select_next_item() },
    ["<C-p>"] = { c = cmp.mapping.select_prev_item() },
    ["<CR>"] = { c = cmp.mapping.confirm({ select = false }) },
  }),
  sources = {
    { name = "buffer" },
  },
})

require("lsp_signature").setup({
  bind = true,
  hint_enable = false,
  hi_parameter = "Visual",
  handler_opts = { border = "single" },
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = "typst",
  callback = function()
    vim.b.lsp_signature_enabled = false
  end,
})
