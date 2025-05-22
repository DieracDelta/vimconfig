require("node-type").setup({})
require("floating-input").setup({})
require("copilot").setup({
  suggestion = { enable = true },
  panel = { enabled = true },
  copilot_node_command = "node",
})
vim.g.coq_settings = {
  auto_start = "shut-up",
  keymap = { recommended = false },
}
require("coq")
-- require("coq_3p")({
--   { src = "nvimlua", short_name = "nLUA" },
--   { src = "copilot", short_name = "COP", accept_key = "<c-f>" },
-- })
-- require('copilot_cmp').setup({
--   method = "getCompletionsCycling",
--   formatters = {
--     insert_text = require("copilot_cmp.format").remove_existing,
--   },
-- })
require("fidget").setup({})
require("crates").setup({
  text = {
    loading = "  Loading...",
    version = "  %s",
    prerelease = "  %s",
    yanked = "  %s yanked",
    nomatch = "  Not found",
    upgrade = "  %s",
    error = "  Error fetching crate",
  },
  popup = {
    text = {
      title = " # %s ",
      version = " %s ",
      prerelease = " %s ",
      yanked = " %s yanked ",
      feature = "   %s ",
      enabled = " * %s ",
      transitive = " ~ %s ",
    },
  },
})

require("trouble").setup({})
require("lspconfig").terraformls.setup({
  cmd = { "terraform-lsp" },
})
require("lspconfig").lua_ls.setup({
  cmd = { "lua-language-server" },
  settings = {
    Lua = {
      runtime = {
        version = "LuaJIT",
      },
      diagnostics = {
        globals = { "vim" },
      },
      workspace = {
        library = vim.api.nvim_get_runtime_file("", true),
      },
      telemetry = {
        enable = false,
      },
    },
  },
})

require("lspconfig").clangd.setup({
  cmd = { "clangd" },
})

require("lspconfig").gopls.setup({
  cmd = { "gopls" },
})

require("lspconfig").r_language_server.setup({
  cmd = { "R", "--slave", "-e", "langaugeserver::run()" },
})

require("lsp_signature").setup({
  bind = true,
  hint_enable = false,
  hi_parameter = "Visual",
  handler_opts = { border = "single" },
})

-- require('cmp').setup({
--   mapping = {
--     ['<C-n>'] = require('cmp').mapping.select_next_item({ behavior = require('cmp').SelectBehavior.Insert }),
--     ['<C-p>'] = require('cmp').mapping.select_prev_item({ behavior = require('cmp').SelectBehavior.Insert }),
--     ['<Down>'] = require('cmp').mapping.select_next_item({ behavior = require('cmp').SelectBehavior.Select }),
--     ['<Up>'] = require('cmp').mapping.select_prev_item({ behavior = require('cmp').SelectBehavior.Select }),
--     ['<C-d>'] = require('cmp').mapping.scroll_docs(-4),
--     ['<C-f>'] = require('cmp').mapping.scroll_docs(4),
--     ['<C-Space>'] = require('cmp').mapping.complete(),
--     ['<C-e>'] = require('cmp').mapping.close(),
--     ['<CR>'] = require('cmp').mapping.confirm({ behavior = require('cmp').ConfirmBehavior.Replace, select = true, }),
--   },
--   sources = {
--     { name = "copilot", },
--     { name = "nvim_lsp", },
--     { name = "vsnip", },
--     { name = "buffer", },
--     { name = "crates", },
--   },
--   snippet = {expand = function(args) vim.fn['vsnip#anonymous'](args.body) end},
--   -- formatting = {
--   --   format = {
--   --     require('lspkind').cmp_format({
--   --       mode = "symbol",
--   --       maxwidth = 50,
--   --       ellipsis_char = '...',
--   --       symbol_map = { Suggestion = ""},
--   --     })
--   --   }
--   -- },
--   -- enabled =
--   -- function()
--   --   return vim.api.nvim_buf_get_option(0, "buftype") ~= "prompt"
--   -- end,
-- })

-- vim.api.nvim_set_keymap("i", "<Tab>", "vsnip#available(1)  ? '<Plug>(vsnip-jump-next)': '<Tab>'", {expr = true})
-- vim.api.nvim_set_keymap("s", "<Tab>", "vsnip#available(1)  ? '<Plug>(vsnip-jump-next)': '<Tab>'", {expr = true})
-- vim.api.nvim_set_keymap("i", "<S-Tab>", "vsnip#available(-1)  ? '<Plug>(vsnip-jump-prev)': '<S-Tab>'", {expr = true})
-- vim.api.nvim_set_keymap("s", "<S-Tab>", "vsnip#available(-1)  ? '<Plug>(vsnip-jump-prev)': '<S-Tab>'", {expr = true})
-- vim.api.nvim_set_keymap("i", "<C-j>", "vsnip#available(1)  ? '<Plug>(vsnip-expand-or-jump)' : '<C-j>'", {expr = true})
-- vim.api.nvim_set_keymap("s", "<C-j>", "vsnip#available(1)  ? '<Plug>(vsnip-expand-or-jump)' : '<C-j>'", {expr = true})

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

require("lspconfig").jsonls.setup({
  cmd = { "vscode-json-languageserver", "--stdio" },
  capabilities = capabilities,
})

function show_documentation()
  local filetype = vim.bo.filetype
  if vim.tbl_contains({ "vim", "help" }, filetype) then
    vim.cmd("h " .. vim.fn.expand("<cword>"))
  elseif vim.tbl_contains({ "man" }, filetype) then
    vim.cmd("Man " .. vim.fn.expand("<cword>"))
  elseif vim.fn.expand("%:t") == "Cargo.toml" then
    require("crates").show_popup()
  elseif string.match(filetype, "rust") == "rust" then
    -- technically same as else statement
    -- keeping it here in case I migrate to something else
    -- also don't want to conflict with ferris
    vim.cmd.RustLsp({ "hover", "actions" })
  else
    vim.lsp.buf.hover()
  end
end

vim.fn.setenv("CARGO_TARGET_DIR", "target_dirs/nix_ra")

require("lspconfig").tinymist.setup({})
require("typescript-tools").setup({
  tsserver_path = "./node_modules/typescript/lib/",
})
require("image").setup({})
vim.g.typst_cmd = "typst"
vim.g.typst_pdf_viewer = "zathura"
vim.g.typst_conceal = true

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
vim.api.nvim_set_keymap("n", "<leader>mb", "<cmd>TypstWatch<cr>", {})
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

vim.api.nvim_set_keymap("n", "<leader>cu", '<cmd>lua require("crates").update_crate()<cr>', {})
vim.api.nvim_set_keymap("n", "<leader>cua", '<cmd>lua require("crates").update_all_crate()<cr>', {})
vim.api.nvim_set_keymap("n", "<leader>cU", '<cmd>lua require("crates").upgrade_crate()<cr>', {})
vim.api.nvim_set_keymap("n", "<leader>cUa", '<cmd>lua require("crates").upgrade_all_crate()<cr>', {})

vim.api.nvim_set_keymap("n", "<leader>na", '<cmd>lua require("ts-node-action").node_action({})<cr>', {})
vim.api.nvim_set_keymap("n", "<leader>", "<cmd><cr>", {})
vim.api.nvim_set_keymap("n", "<leader>", "<cmd><cr>", {})
vim.api.nvim_set_keymap("n", "<leader>", "<cmd><cr>", {})
vim.api.nvim_set_keymap("n", "<leader>", "<cmd><cr>", {})

vim.api.nvim_set_keymap("n", "<leader>", "<cmd><cr>", {})
vim.api.nvim_set_keymap("n", "<leader>", "<cmd><cr>", {})
vim.api.nvim_set_keymap("n", "<leader>", "<cmd><cr>", {})

vim.api.nvim_set_keymap("n", "<leader>", "<cmd><cr>", {})
vim.api.nvim_set_keymap("n", "<leader>", "<cmd><cr>", {})
vim.api.nvim_set_keymap("n", "<leader>", "<cmd><cr>", {})

vim.api.nvim_set_keymap("n", "<leader>", "<cmd><cr>", {})
vim.api.nvim_set_keymap("n", "<leader>", "<cmd><cr>", {})
vim.api.nvim_set_keymap("n", "<leader>", "<cmd><cr>", {})

vim.api.nvim_set_keymap("n", "<leader>", "<cmd><cr>", {})
vim.api.nvim_set_keymap("n", "<leader>", "<cmd><cr>", {})
vim.api.nvim_set_keymap("n", "<leader>", "<cmd><cr>", {})

vim.g.loaded_coqtail = 1
vim.g["coqtail#supported"] = 0
require("coq-lsp").setup()

require("lspconfig").ocamllsp.setup({
  cmd = { "ocamllsp", "--fallback-read-dot-merlin" },
})

vim.api.nvim_create_autocmd({ "BufWritePost" }, {
  pattern = { "*.ml", "*.mli" },
  callback = function()
    vim.wo.foldenable = false
  end,
})

require("lspconfig").nil_ls.setup({
  settings = {
    ["nil"] = {
      nix = {
        flake = {
          autoArchive = false,
          autoEvalInputs = false,
        },
      },
    },
  },
})

require("lspconfig").ruff.setup({
  init_options = {
    settings = {},
  },
})

local r = require("symbols.recipes")
require("symbols").setup(r.DefaultFilters, r.AsciiSymbols, {
  sidebar = { hide_cursor = false },
  provider = { lsp = { timeout_ms = 10000 } },
  -- custom settings here
  -- e.g. hide_cursor = false
})
vim.keymap.set("n", "<leader>s", "<cmd> SymbolsToggle<CR>")

-- credit: mostly https://github.com/garbas/dotfiles/blob/d631889b37b1b124249db1912216e11e6f12f3d5/homeConfigurations/profiles/common_neovim.nix#L881

require("conform").setup({
  formatters_by_ft = {
    nix = { "nixfmt" },
    gofmt = { "gofmt" },
    ruff_format = { "ruff" },
    lua = { "stylua" },
    rustfmt = { "rustfmt" },
    shellcheck = { "shellcheck" },
    shfmt = { "shfmt" },
  },
  -- Command to toggle format-on-save
  -- https://github.com/stevearc/conform.nvim/blob/master/doc/recipes.md#command-to-toggle-format-on-save
  format_on_save = function(bufnr)
    -- Disable with a global or buffer-local variable
    if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
      return
    end
    return { timeout_ms = 500, lsp_format = "fallback" }
  end,
})
vim.api.nvim_create_user_command("FormatDisable", function(args)
  if args.bang then
    -- FormatDisable! will disable formatting just for this buffer
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
