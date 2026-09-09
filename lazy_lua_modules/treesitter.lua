local lze = require("lze")

vim.filetype.add({
  extension = {
    vi = "vilang",
    vilang = "vilang",
  },
})

local function is_big_file(buf)
  local max_lines = 10000
  local max_size = 1024 * 1024 -- 1MB

  local lines = vim.api.nvim_buf_line_count(buf)
  if lines > max_lines then
    return true
  end

  local ok, stats = pcall(vim.uv.fs_stat, vim.api.nvim_buf_get_name(buf))
  if ok and stats and stats.size > max_size then
    return true
  end

  return false
end

lze.load({
  "nvim-treesitter",
  event = { "BufReadPre", "BufNewFile" },
  after = function()
    require("treesitter-modules").setup({
      highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
        disable = function(ctx)
          return is_big_file(ctx.buf)
        end,
      },
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = "<C-n>",
          node_incremental = "<C-n>",
          scope_incremental = "<C-s>",
          node_decremental = "<C-p>",
        },
        disable = function(ctx)
          return is_big_file(ctx.buf)
        end,
      },
    })

    require("nvim-treesitter-textobjects").setup({
      select = { lookahead = true },
      move = { set_jumps = true },
    })

    local select_textobject = require("nvim-treesitter-textobjects.select").select_textobject
    local select_mappings = {
      tfo = "@function.outer",
      tfi = "@function.inner",
      tco = "@class.outer",
      tci = "@class.inner",
      too = "@conditional.outer",
      toi = "@conditional.inner",
      tuo = "@comment.outer",
      tui = "@comment.inner",
      tpo = "@parameter.outer",
      tpi = "@parameter.inner",
      tlo = "@loop.outer",
      tli = "@loop.inner",
      tbo = "@block.outer",
      tbi = "@block.inner",
      teo = "@statement.outer",
      tei = "@statement.inner",
    }
    for key, capture in pairs(select_mappings) do
      local query = capture
      vim.keymap.set({ "x", "o" }, key, function()
        select_textobject(query, "textobjects")
      end)
    end

    local move = require("nvim-treesitter-textobjects.move")
    local move_mappings = {
      goto_next_start = {
        tmf = "@function.outer",
        tmc = "@class.outer",
        tmo = "@conditional.outer",
        tmu = "@comment.outer",
        tmp = "@parameter.outer",
        tml = "@loop.outer",
        tmb = "@block.outer",
        tms = "@statement.outer",
      },
      goto_next_end = {
        tmF = "@function.outer",
        tmC = "@class.outer",
        tmO = "@conditional.outer",
        tmU = "@comment.outer",
        tmP = "@parameter.outer",
        tmL = "@loop.outer",
        tmB = "@block.outer",
        tmS = "@statement.outer",
      },
      goto_previous_start = {
        tMf = "@function.outer",
        tMc = "@class.outer",
        tMo = "@conditional.outer",
        tMu = "@comment.outer",
        tMp = "@parameter.outer",
        tMl = "@loop.outer",
        tMb = "@block.outer",
        tMs = "@statement.outer",
      },
      goto_previous_end = {
        tMF = "@function.outer",
        tMC = "@class.outer",
        tMO = "@conditional.outer",
        tMU = "@comment.outer",
        tMP = "@parameter.outer",
        tML = "@loop.outer",
        tMB = "@block.outer",
        tMS = "@statement.outer",
      },
    }
    for method, mappings in pairs(move_mappings) do
      local move_textobject = move[method]
      for key, capture in pairs(mappings) do
        local query = capture
        vim.keymap.set({ "n", "x", "o" }, key, function()
          move_textobject(query, "textobjects")
        end)
      end
    end

    local swap = require("nvim-treesitter-textobjects.swap")
    local swap_mappings = {
      swap_next = {
        tsf = "@function.outer",
        tsc = "@class.outer",
        tso = "@conditional.outer",
        tsu = "@comment.outer",
        tsp = "@parameter.outer",
        tsl = "@loop.outer",
        tsb = "@block.outer",
        tss = "@statement.outer",
      },
      swap_previous = {
        tSf = "@function.outer",
        tSc = "@class.outer",
        tSo = "@conditional.outer",
        tSu = "@comment.outer",
        tSp = "@parameter.outer",
        tSl = "@loop.outer",
        tSb = "@block.outer",
        tSs = "@statement.outer",
      },
    }
    for method, mappings in pairs(swap_mappings) do
      local swap_textobject = swap[method]
      for key, capture in pairs(mappings) do
        local query = capture
        vim.keymap.set("n", key, function()
          swap_textobject(query)
        end)
      end
    end

    require("nvim-ts-autotag").setup({})

    local rainbow_groups = {}
    for index, color in ipairs({
      "#bd93f9",
      "#6272a4",
      "#8be9fd",
      "#50fa7b",
      "#f1fa8c",
      "#ffb86c",
      "#ff5555",
    }) do
      local group = "RainbowDelimiterCustom" .. index
      vim.api.nvim_set_hl(0, group, { fg = color })
      table.insert(rainbow_groups, group)
    end
    require("rainbow-delimiters.setup").setup({ highlight = rainbow_groups })
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
