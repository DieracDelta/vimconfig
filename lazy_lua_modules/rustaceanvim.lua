require("lze").load {
  "rustaceanvim",
  ft = {"rust"},
  before = function()
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
  end,
 after = function()
    vim.cmd("doautocmd FileType rust")
 end,
}
