local lze = require("lze")

local function is_big_file(buf)
  local max_lines = 10000
  local max_size = 1024 * 1024 -- 1MB
  
  local lines = vim.api.nvim_buf_line_count(buf)
  if lines > max_lines then
    return true
  end
  
  local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
  if ok and stats and stats.size > max_size then
    return true
  end
  
  return false
end

lze.load({
  "nvim-treesitter",
  event = { "BufReadPre", "BufNewFile" },
  after = function()
    require("nvim-treesitter.configs").setup({
      ensure_installed = {},
      markid = {
        enable = true,
        disable = function(_, buf) return is_big_file(buf) end,
      },
      highlight = {
        enable = true,
        use_languagetree = false,
        additional_vim_regex_highlighting = false,
        disable = function(_, buf) return is_big_file(buf) end,
      },
      ignore = { "QuickScopePrimary", "QuickScopeSecondary" },
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = "<C-n>",
          node_incremental = "<C-n>",
          scope_incremental = "<C-s>",
          node_decremental = "<C-p>",
        },
        disable = function(_, buf) return is_big_file(buf) end,
      },
      rainbow = {
        enable = true,
        disable = function(_, buf) return is_big_file(buf) end,
        extended_mode = true,
        max_file_lines = 10000,
        colors = {
          "#bd93f9",
          "#6272a4",
          "#8be9fd",
          "#50fa7b",
          "#f1fa8c",
          "#ffb86c",
          "#ff5555",
        },
      },
      textobjects = {
        select = {
          enable = true,
          lookahead = true,
          keymaps = {
            ["tfo"] = "@function.outer",
            ["tfi"] = "@function.inner",
            ["tco"] = "@class.outer",
            ["tci"] = "@class.inner",
            ["too"] = "@conditional.outer",
            ["toi"] = "@conditional.inner",
            ["tuo"] = "@comment.outer",
            ["tui"] = "@comment.inner",
            ["tpo"] = "@param.outer",
            ["tpi"] = "@param.inner",
            ["tlo"] = "@loop.outer",
            ["tli"] = "@loop.inner",
            ["tbo"] = "@block.outer",
            ["tbi"] = "@block.inner",
            ["teo"] = "@statement.outer",
            ["tei"] = "@statement.inner",
          },
        },
        move = {
          enable = true,
          set_jumps = true,
          goto_next_start = {
            ["tmf"] = "@function.outer",
            ["tmc"] = "@class.outer",
            ["tmo"] = "@conditional.outer",
            ["tmu"] = "@comment.outer",
            ["tmp"] = "@param.outer",
            ["tml"] = "@loop.outer",
            ["tmb"] = "@block.outer",
            ["tms"] = "@statement.outer",
          },
          goto_next_end = {
            ["tmF"] = "@function.outer",
            ["tmC"] = "@class.outer",
            ["tmO"] = "@conditional.outer",
            ["tmU"] = "@comment.outer",
            ["tmP"] = "@param.outer",
            ["tmL"] = "@loop.outer",
            ["tmB"] = "@block.outer",
            ["tmS"] = "@statement.outer",
          },
          goto_previous_start = {
            ["tMf"] = "@function.outer",
            ["tMc"] = "@class.outer",
            ["tMo"] = "@conditional.outer",
            ["tMu"] = "@comment.outer",
            ["tMp"] = "@param.outer",
            ["tMl"] = "@loop.outer",
            ["tMb"] = "@block.outer",
            ["tMs"] = "@statement.outer",
          },
          goto_previous_end = {
            ["tMF"] = "@function.outer",
            ["tMC"] = "@class.outer",
            ["tMO"] = "@conditional.outer",
            ["tMU"] = "@comment.outer",
            ["tMP"] = "@param.outer",
            ["tML"] = "@loop.outer",
            ["tMB"] = "@block.outer",
            ["tMS"] = "@statement.outer",
          },
        },
        swap = {
          enable = true,
          swap_next = {
            ["tsf"] = "@function.outer",
            ["tsc"] = "@class.outer",
            ["tso"] = "@conditional.outer",
            ["tsu"] = "@comment.outer",
            ["tsp"] = "@param.outer",
            ["tsl"] = "@loop.outer",
            ["tsb"] = "@block.outer",
            ["tss"] = "@statement.outer",
          },
          swap_previous = {
            ["tSf"] = "@function.outer",
            ["tSc"] = "@class.outer",
            ["tSo"] = "@conditional.outer",
            ["tSu"] = "@comment.outer",
            ["tSp"] = "@param.outer",
            ["tSl"] = "@loop.outer",
            ["tSb"] = "@block.outer",
            ["tSs"] = "@statement.outer",
          },
        },
        lsp_interop = {
          enable = true,
          border = "none",
          peek_definition_code = {
            ["<leader>df"] = "@function.outer",
            ["<leader>dF"] = "@class.outer",
          },
        },
      },
      autotag = {
        enable = true,
        disable = function(_, buf) return is_big_file(buf) end,
      },
    })
  end,
})

lze.load({
  "nvim-ufo",
  event = { "BufReadPost" }, 
  after = function()
    vim.keymap.set("n", "zR", require("ufo").openAllFolds)
    vim.keymap.set("n", "zM", require("ufo").closeAllFolds)
    require("ufo").setup({
      preview = {
        mappings = {
          scrollU = "k",
          scrollD = "j",
        },
      },
      provider_selector = function(bufnr, filetype, buftype)
        if is_big_file(bufnr) then
          return { "indent" }
        end
        return { "treesitter", "indent" }
      end,
    })
  end,
})

lze.load({
  "comment-nvim",
  keys = {
    { "<leader>c<leader>", desc = "Toggle Comment Line" },
    { "<leader>b<leader>", desc = "Toggle Comment Block" },
    { "<leader>c", mode = "n", desc = "Comment Line Op" },
    { "<leader>b", mode = "n", desc = "Comment Block Op" },
    { "gcc", desc = "Comment Line" },
    { "gbc", desc = "Comment Block" },
  },
  after = function()
    require("Comment").setup({
      toggler = {
        line = "<leader>c<leader>",
        block = "<leader>b<leader>",
      },
      opleader = {
        line = "<leader>c",
        block = "<leader>b",
      },
      extra = {
        above = "<leader>cO",
        below = "<leader>co",
        eol = "<leader>cA",
      },
    })
  end,
})

lze.load({
  "vim-illuminate",
  event = { "BufReadPost" },
  after = function()
    require("illuminate").configure({
      providers = {
        "lsp",
        "treesitter",
        "regex",
      },
      delay = 100,
      under_cursor = true,
      large_file_cutoff = 3000, -- Lines
      large_file_overrides = {
        providers = { "lsp" },
      },
    })
    require("illuminate").resume()
  end,
})

lze.load({
  "ts-node-action",
  keys = {
    { "<leader>na", desc = "Node Action" },
  },
  after = function()
    vim.api.nvim_set_keymap("n", "<leader>na", '<cmd>lua require("ts-node-action").node_action({})<cr>', {})
  end,
})

lze.load({
  "markid",
  event = { "BufReadPre" },
})