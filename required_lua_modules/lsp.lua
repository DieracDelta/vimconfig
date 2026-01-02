require("node-type").setup({})
require("floating-input").setup({})
local cmp = require("cmp")

local mappings = {
  ["<C-n>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
  ["<C-p>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),

  ["<C-f>"] = cmp.mapping.scroll_docs(4),
  ["<C-d>"] = cmp.mapping.scroll_docs(-4),

  ["<CR>"] = cmp.mapping.confirm({
    select = false,
  }),

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
    ["<C-n>"] = {
      c = cmp.mapping.select_next_item(),
    },
    ["<C-p>"] = {
      c = cmp.mapping.select_prev_item(),
    },
    ["<CR>"] = {
      c = cmp.mapping.confirm({ select = false }),
    },
  }),

  sources = {
    { name = "path" },
    { name = "cmdline" },
  },
})

cmp.setup.cmdline({ "/", "?" }, {
  mapping = cmp.mapping.preset.cmdline({
    ["<C-n>"] = {
      c = cmp.mapping.select_next_item(),
    },
    ["<C-p>"] = {
      c = cmp.mapping.select_prev_item(),
    },
    ["<CR>"] = {
      c = cmp.mapping.confirm({ select = false }),
    },
  }),

  sources = {
    { name = "buffer" },
  },
})

require("fidget").setup({})

require("trouble").setup({})
vim.api.nvim_set_keymap("n", "<leader>t", "<cmd>Trouble<cr>", {})

require("lsp_signature").setup({
  bind = true,
  hint_enable = false,
  hi_parameter = "Visual",
  handler_opts = { border = "single" },
})

function show_documentation()
  local filetype = vim.bo.filetype
  if vim.tbl_contains({ "vim", "help" }, filetype) then
    vim.cmd("h " .. vim.fn.expand("<cword>"))
  elseif vim.tbl_contains({ "man" }, filetype) then
    vim.cmd("Man " .. vim.fn.expand("<cword>"))
  elseif vim.fn.expand("%:t") == "Cargo.toml" then
    -- Attempt to require crates, if loaded it works, if not it might need loading?
    -- Since we lazy load on Cargo.toml, it should be loaded.
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
vim.api.nvim_set_keymap("n", "<leader>f", "<cmd>lua vim.lsp.buf.formatting()<cr>", {})

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

local r = require("symbols.recipes")
require("symbols").setup(r.DefaultFilters, r.AsciiSymbols, {
  sidebar = { hide_cursor = false },
  provider = { lsp = { timeout_ms = 10000 } },
})
vim.keymap.set("n", "<leader>s", "<cmd> SymbolsToggle<CR>")

require("conform").setup({
  formatters_by_ft = {
    nix = { "nixfmt" },
    gofmt = { "gofmt" },
    ruff_format = { "ruff" },
    lua = { "stylua" },
    rustfmt = { "rustfmt" },
    shellcheck = { "shellcheck" },
    shfmt = { "shfmt" },
    just = { "just" },
    typst = { "prettypst" },
    html = { "prettierd" },
    ocaml = { "ocamlformat" },
    haskell = { "fourmolu" },
  },
  format_on_save = function(bufnr)
    if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
      return
    end
    return { timeout_ms = 500, lsp_format = "fallback" }
  end,
})

vim.api.nvim_create_user_command("FormatDisable", function(args)
  if args.bang then
    vim.b.disable_autoformat = true
  else
    vim.g.disable_autoformat = true
  end
end, {
  desc = "Disable autoformat-on-save",
  bang = true,
})
vim.api.nvim_create_user_command("FormatEnable", function()
  vim.b.disable_autoformat = false
  vim.g.disable_autoformat = false
end, {
  desc = "Re-enable autoformat-on-save",
})

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