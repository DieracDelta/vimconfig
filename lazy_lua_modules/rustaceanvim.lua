require("lze").load {
  "rustaceanvim",
  ft = {"rust"},
  before = function()
    require('lspconfig').rustowl = {
      cmd = "rustowl",
      filetypes = { "rust"},
      root_markers = {".git", "Cargo.lock"},
    }
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
  end,
  after = function()
    vim.cmd("doautocmd FileType rust")
  end,
}
