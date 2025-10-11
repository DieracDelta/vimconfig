require("lze").load({
  "rustaceanvim",
  ft = { "rust" },
  before = function()
    -- require("lspconfig").rustowl = {
    --   cmd = "rustowl",
    --   filetypes = { "rust" },
    --   root_markers = { ".git", "Cargo.lock" },
    -- }
    local root = vim.fn.getcwd()
    local git_root = vim.fn.systemlist("git rev-parse --show-toplevel")[1]
    if vim.v.shell_error == 0 and git_root and #git_root > 0 then
      root = git_root
    end

    -- load per-project nvim_config.lua if it exists
    local config_path = root .. "/nvim_config.lua"
    local project_settings = nil

    if vim.fn.filereadable(config_path) == 1 then
      local ok, cfg = pcall(dofile, config_path)
      if ok and type(cfg) == "table" then
        project_settings = cfg
      else
        vim.notify("Failed to load project nvim_config.lua", vim.log.levels.WARN)
      end
    end

    vim.g.rustaceanvim = {
      client = { server_capabilities = { inlayHintProvider = true } },
      server = {
        settings = project_settings or {},
      },
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
})
