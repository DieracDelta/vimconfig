require('node-type').setup({})
require('floating-input').setup({})
require('copilot').setup({
  suggestion = { enable = true, },
  panel = { enabled = true, },
  copilot_node_command = "node",
})
require('copilot_cmp').setup({
  method = "getCompletionsCycling",
  formatters = {
    insert_text = require("copilot_cmp.format").remove_existing,
  },
})
require('fidget').setup({})
require('crates').setup({
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

require('trouble').setup({})
require('lspconfig').terraformls.setup({
  cmd = {"terraform-lsp"},
})
require('lspconfig').lua_ls.setup({
  cmd = {'lua-language-server'},
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

require('lspconfig').clangd.setup({
  cmd = {"clangd"}
})

require('lspconfig').gopls.setup({
  cmd = {"gopls"}
})

require('lspconfig').r_language_server.setup({
  cmd = {"R", "--slave", "-e", "langaugeserver::run()" },
})

require('lsp_signature').setup({
  bind = true,
  hint_enable = false,
  hi_parameter = "Visual",
  handler_opts = {border = "single"},
})

require('cmp').setup({
  mapping = {
    ['<C-n>'] = require('cmp').mapping.select_next_item({ behavior = require('cmp').SelectBehavior.Insert }),
    ['<C-p>'] = require('cmp').mapping.select_prev_item({ behavior = require('cmp').SelectBehavior.Insert }),
    ['<Down>'] = require('cmp').mapping.select_next_item({ behavior = require('cmp').SelectBehavior.Select }),
    ['<Up>'] = require('cmp').mapping.select_prev_item({ behavior = require('cmp').SelectBehavior.Select }),
    ['<C-d>'] = require('cmp').mapping.scroll_docs(-4),
    ['<C-f>'] = require('cmp').mapping.scroll_docs(4),
    ['<C-Space>'] = require('cmp').mapping.complete(),
    ['<C-e>'] = require('cmp').mapping.close(),
    ['<CR>'] = require('cmp').mapping.confirm({ behavior = require('cmp').ConfirmBehavior.Replace, select = true, }),
  },
  sources = {
    { name = "copilot", },
    { name = "nvim_lsp", },
    { name = "vsnip", },
    { name = "buffer", },
    { name = "crates", },
  },
  snippet = {expand = function(args) vim.fn['vsnip#anonymous'](args.body) end},
  -- formatting = {
  --   format = {
  --     require('lspkind').cmp_format({
  --       mode = "symbol",
  --       maxwidth = 50,
  --       ellipsis_char = '...',
  --       symbol_map = { Suggestion = ""},
  --     })
  --   }
  -- },
  -- enabled =
  -- function()
  --   return vim.api.nvim_buf_get_option(0, "buftype") ~= "prompt"
  -- end,
})

vim.api.nvim_set_keymap("i", "<Tab>", "vsnip#available(1)  ? '<Plug>(vsnip-jump-next)': '<Tab>'", {expr = true})
vim.api.nvim_set_keymap("s", "<Tab>", "vsnip#available(1)  ? '<Plug>(vsnip-jump-next)': '<Tab>'", {expr = true})
vim.api.nvim_set_keymap("i", "<S-Tab>", "vsnip#available(-1)  ? '<Plug>(vsnip-jump-prev)': '<S-Tab>'", {expr = true})
vim.api.nvim_set_keymap("s", "<S-Tab>", "vsnip#available(-1)  ? '<Plug>(vsnip-jump-prev)': '<S-Tab>'", {expr = true})
vim.api.nvim_set_keymap("i", "<C-j>", "vsnip#available(1)  ? '<Plug>(vsnip-expand-or-jump)' : '<C-j>'", {expr = true})
vim.api.nvim_set_keymap("s", "<C-j>", "vsnip#available(1)  ? '<Plug>(vsnip-expand-or-jump)' : '<C-j>'", {expr = true})

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

require'lspconfig'.jsonls.setup {
  cmd = { 'vscode-json-languageserver', '--stdio'},
  capabilities = capabilities,
}

function show_documentation()
  local winid = require('ufo').peekFoldedLinesUnderCursor()
  if not winid then
    local filetype = vim.bo.filetype
    if vim.tbl_contains({ 'vim','help' }, filetype) then
      vim.cmd('h '..vim.fn.expand('<cword>'))
    elseif vim.tbl_contains({ 'man' }, filetype) then
      vim.cmd('Man '..vim.fn.expand('<cword>'))
    elseif vim.fn.expand('%:t') == 'Cargo.toml' then
      require('crates').show_popup()
    elseif string.match(filetype, 'rust') == "rust" then
      -- technically same as else statement
      -- keeping it here in case I migrate to something else
      -- also don't want to conflict with ferris
      vim.cmd.RustLsp {'hover', 'actions'}
    else
      vim.lsp.buf.hover()
    end
  end
end

vim.fn.setenv("CARGO_TARGET_DIR", "target_dirs/nix_ra")

require('haskell-tools')
require('telescope').load_extension('ht')
require'lspconfig'.typst_lsp.setup{}
require("typescript-tools").setup {
  tsserver_path = "./node_modules/typescript/lib/",
}
require('ferris').setup({})
require('image').setup({})
vim.g.typst_cmd = 'typst'
vim.g.typst_pdf_viewer = 'zathura'
vim.g.typst_conceal = true

vim.api.nvim_set_keymap('n', 'K', '<cmd>lua show_documentation()<cr>', {})
vim.api.nvim_set_keymap('n', '<leader>D', '<cmd>lua vim.lsp.buf.declaration()<cr>', {})
vim.api.nvim_set_keymap('n', '<leader>d', '<cmd>lua vim.lsp.buf.definition()<cr>', {})
vim.api.nvim_set_keymap('n', '<leader>i', '<cmd>lua vim.lsp.buf.implementation()<cr>', {})
vim.api.nvim_set_keymap('n', '<leader>s', '<cmd>lua vim.lsp.buf.signature_help()<cr>', {})
vim.api.nvim_set_keymap('n', '<leader>k', '<cmd>vim.lsp.buf.type_definition()<cr>', {})
vim.api.nvim_set_keymap('n', '<leader>rn', '<cmd>lua lsp.buf.rename()<cr>', {})
vim.api.nvim_set_keymap('n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<cr>', {})
vim.api.nvim_set_keymap('n', '<leader>r', '<cmd>lua vim.lsp.buf.references()<cr>', {})
vim.api.nvim_set_keymap('n', '<leader>e', '<cmd>vim.diagnostic.open_float()<cr>', {})
vim.api.nvim_set_keymap('n', '<leader>dn', '<cmd>lua vim.diagnostic.goto_next()<cr>', {})
vim.api.nvim_set_keymap('n', '<leader>dp', '<cmd>lua vim.diagnostic.goto_prev()<cr>', {})
vim.api.nvim_set_keymap('n', '<leader>mb', '<cmd>TypstWatch<cr>', {})
vim.api.nvim_set_keymap('n', '<leader>f', '<cmd>lua vim.lsp.buf.formatting()<cr>', {})




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
vim.g.rustaceanvim = {
  client = { server_capabilities = { inlayHintProvider = true } },
  tools = {
    autoSetHints = true,
    runnables = { use_telescope = true },
    inlay_hints = {

      only_current_line = false,
      only_current_line_autocmd = "CursorMoved",

      show_parameter_hints = true,

      parameter_hints_prefix = "<- ",
      other_hints_prefix = "=> ",

      max_len_align = false,

      max_len_align_padding = 1,

      right_align = false,

      right_align_padding = 7,
      highlight = "DiagnosticSignWarn",
    },
  },
}

vim.api.nvim_set_keymap('n', '<leader>rl', '<cmd>lua require("ferris.methods.view_memory_layout")()<cr>', {})
vim.api.nvim_set_keymap('n', '<leader>rhi', '<cmd>lua require("ferris.methods.view_hir")()<cr>', {})
vim.api.nvim_set_keymap('n', '<leader>rmi', '<cmd>lua require("ferris.methods.view_mir")()<cr>', {})
vim.api.nvim_set_keymap('n', '<leader>rb', '<cmd>lua require("ferris.methods.rebuild_macros")()<cr>', {})
vim.api.nvim_set_keymap('n', '<leader>rm', '<cmd>lua vim.cmd.RustLsp("expandMacro")<cr>', {})
vim.api.nvim_set_keymap('n', '<leader>rh', '<cmd>lua toggle_inlay_hints()<cr>', {})
vim.api.nvim_set_keymap('n', '<leader>cu', '<cmd>lua require("crates").update_crate()<cr>', {})
vim.api.nvim_set_keymap('n', '<leader>cua', '<cmd>lua require("crates").update_all_crate()<cr>', {})
vim.api.nvim_set_keymap('n', '<leader>cU', '<cmd>lua require("crates").upgrade_crate()<cr>', {})
vim.api.nvim_set_keymap('n', '<leader>cUa', '<cmd>lua require("crates").upgrade_all_crate()<cr>', {})

vim.api.nvim_set_keymap('n', '<leader>na', '<cmd>lua require("ts-node-action").node_action({})<cr>', {})
vim.api.nvim_set_keymap('n', '<leader>', '<cmd><cr>', {})
vim.api.nvim_set_keymap('n', '<leader>', '<cmd><cr>', {})
vim.api.nvim_set_keymap('n', '<leader>', '<cmd><cr>', {})
vim.api.nvim_set_keymap('n', '<leader>', '<cmd><cr>', {})



vim.api.nvim_set_keymap('n', '<leader>', '<cmd><cr>', {})
vim.api.nvim_set_keymap('n', '<leader>', '<cmd><cr>', {})
vim.api.nvim_set_keymap('n', '<leader>', '<cmd><cr>', {})



vim.api.nvim_set_keymap('n', '<leader>', '<cmd><cr>', {})
vim.api.nvim_set_keymap('n', '<leader>', '<cmd><cr>', {})
vim.api.nvim_set_keymap('n', '<leader>', '<cmd><cr>', {})



vim.api.nvim_set_keymap('n', '<leader>', '<cmd><cr>', {})
vim.api.nvim_set_keymap('n', '<leader>', '<cmd><cr>', {})
vim.api.nvim_set_keymap('n', '<leader>', '<cmd><cr>', {})



vim.api.nvim_set_keymap('n', '<leader>', '<cmd><cr>', {})
vim.api.nvim_set_keymap('n', '<leader>', '<cmd><cr>', {})
vim.api.nvim_set_keymap('n', '<leader>', '<cmd><cr>', {})
