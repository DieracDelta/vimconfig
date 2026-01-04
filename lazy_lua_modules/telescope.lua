local lze = require("lze")

lze.load({
  "telescope.nvim",
  cmd = { "Telescope" },
  keys = {
    { "<leader>bb", "<cmd>lua require('telescope.builtin').buffers()<cr>", desc = "Buffers" },
    { "<leader>gg", "<cmd>lua require('telescope.builtin').live_grep()<cr>", desc = "Live Grep" },
    { "<leader><leader>", "<cmd>lua require('telescope.builtin').find_files()<cr>", desc = "Find Files" },
    { "<leader>gf", "<cmd>lua require('telescope.builtin').grep_string()<cr>", desc = "Grep Function" },
    { "<leader>l", "<cmd>lua require('telescope.builtin').resume()<cr>", desc = "Resume" },
    { "<leader>bc", "<cmd>lua coq_panels_picker()<cr>", desc = "Coq Panels" },
  },
  after = function()
    require("telescope").setup({
      defaults = {
        preview = { treesitter = true },
        file_ignore_patterns = { "node_modules", "target", "target_dirs" },
        prompt_prefix = "   ",
        selection_caret = "  ",
        entry_prefix = "  ",
        borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
        vimgrep_arguments = {
          "rg",
          "--color=never",
          "--no-heading",
          "--with-filename",
          "--line-number",
          "--column",
          "--smart-case",
        },
      },
      extensions = {
        ["ui-select"] = {
          require("telescope.themes").get_dropdown({
            -- even more opts
          }),
        },
      },
    })
    vim.api.nvim_set_keymap(
      "n",
      "<leader>bb",
      '<cmd>lua require("telescope.builtin").buffers({ file_ignore_patterns = {"^CoqInfoPanel:"} })<cr>',
      { noremap = true, silent = true }
    )
    vim.api.nvim_set_keymap("n", "<leader>gg", "<cmd>lua require('telescope.builtin').live_grep()<cr>", {})
    vim.api.nvim_set_keymap("n", "<leader><leader>", "<cmd>lua require('telescope.builtin').find_files()<cr>", {})
    vim.api.nvim_set_keymap("n", "<leader>gf", "<cmd>lua require('telescope.builtin').grep_string()<cr>", {})
    vim.api.nvim_set_keymap("n", "<leader>l", "<cmd>lua require('telescope.builtin').resume()<cr>", {})

    function coq_panels_picker()
      local telescope = require("telescope")
      local finders = require("telescope.finders")
      local sorters = require("telescope.sorters")
      local actions = require("telescope.actions")
      local action_state = require("telescope.actions.state")

      local all_bufs = vim.api.nvim_list_bufs()
      local coq_bufs = vim.tbl_filter(function(buf)
        local name = vim.api.nvim_buf_get_name(buf)
        return name:match("CoqInfoPanel")
      end, all_bufs)

      require("telescope.builtin").buffers({
        prompt_title = "Coq Info Panels",
        finder = finders.new_table({
          results = coq_bufs,
          entry_maker = function(buf)
            local name = vim.api.nvim_buf_get_name(buf)
            return {
              value = buf,
              display = name,
              ordinal = name,
              bufnr = buf,
            }
          end,
        }),
        sorter = sorters.get_generic_fuzzy_sorter(),
        previewer = false,
        attach_mappings = function(_, map)
          actions.select_default:replace(function(prompt_bufnr)
            local entry = action_state.get_selected_entry()
            actions.close(prompt_bufnr)
            vim.api.nvim_set_current_buf(entry.bufnr)
          end)
          return true
        end,
      })
    end
    vim.api.nvim_set_keymap("n", "<leader>bc", "<cmd>lua coq_panels_picker()<cr>", { noremap = true, silent = true })
  end,
})

lze.load({
  "telescope-zoxide",
  keys = {
    { "<leader>cd", "<cmd>Telescope zoxide list<cr>", desc = "Zoxide" },
  },
  load = function(name)
    vim.cmd("packadd telescope.nvim")
    vim.cmd("packadd " .. name)
  end,
  after = function()
    require("telescope").load_extension("zoxide")
    local z_utils = require("telescope._extensions.zoxide.utils")
    require("telescope").extensions.zoxide.setup({
      prompt_title = "[ Walking on the shoulders of TJ ]",
      mappings = {
        default = {
          after_action = function(selection)
            print("Update to (" .. selection.z_score .. ") " .. selection.path)
          end,
        },
        ["<leader>Z"] = {
          before_action = function(selection)
            print("before C-s")
          end,
          action = function(selection)
            vim.cmd.edit(selection.path)
          end,
        },
        ["<leader>Y"] = { action = z_utils.create_basic_command("split") },
      },
    })
    vim.keymap.set("n", "<leader>cd", require("telescope").extensions.zoxide.list)
  end,
})

lze.load({
  "telescope-live-grep-args.nvim",
  keys = {
    {
      "<leader>gF",
      "<cmd>lua require('telescope').extensions.live_grep_args.live_grep_args()<cr>",
      desc = "Grep Args",
    },
  },
  load = function(name)
    vim.cmd("packadd telescope.nvim")
    vim.cmd("packadd " .. name)
  end,
  after = function()
    require("telescope").load_extension("live_grep_args")
    require("telescope").extensions.live_grep_args.setup({
      auto_quoting = true,
      mappings = {
        i = {
          ["<C-k>"] = require("telescope-live-grep-args.actions").quote_prompt(),
          ["<C-g>"] = require("telescope-live-grep-args.actions").quote_prompt({ postfix = " -g " }),
          ["<C-i>"] = require("telescope-live-grep-args.actions").quote_prompt({ postfix = " --iglob " }),
          ["<C-f>"] = require("telescope-live-grep-args.actions").to_fuzzy_refine,
        },
      },
    })
    vim.keymap.set("n", "<leader>gF", function()
      require("telescope").extensions.live_grep_args.live_grep_args()
    end, {})
  end,
})

-- 4. Telescope File Browser Extension
lze.load({
  "telescope-file-browser.nvim",
  keys = {
    { "<leader>fb", "<cmd>Telescope file_browser<cr>", desc = "File Browser" },
  },
  load = function(name)
    vim.cmd("packadd telescope.nvim")
    vim.cmd("packadd " .. name)
  end,
  after = function()
    require("telescope").load_extension("file_browser")
    vim.api.nvim_set_keymap("n", "<leader>fb", "<cmd>Telescope file_browser<cr>", {})
  end,
})

lze.load({
  "telescope-ui-select",
  load = function(name)
    vim.cmd("packadd telescope.nvim")
    vim.cmd("packadd " .. name)
  end,
  after = function()
    require("telescope").load_extension("ui-select")
  end,
})

lze.load({
  "yazi.nvim",
  keys = {
    { "<leader>z", '<cmd>lua require("yazi").yazi()<cr>', desc = "Yazi" },
  },
  after = function()
    vim.api.nvim_set_keymap("n", "<leader>z", '<cmd>lua require("yazi").yazi()<cr>', {})
  end,
})
