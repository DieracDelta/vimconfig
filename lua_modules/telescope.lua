require("telescope").setup {
  defaults = {
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
      require("telescope.themes").get_dropdown {
        -- even more opts
      }
    }
  }
}
require("telescope").load_extension("file_browser")
require("telescope").load_extension("ui-select")

vim.api.nvim_set_keymap(
  'n',
  '<leader>bb',
  '<cmd>lua require("telescope.builtin").buffers({ file_ignore_patterns = {"^CoqInfoPanel:"} })<cr>',
  { noremap = true, silent = true }
)
vim.api.nvim_set_keymap('n', '<leader>fb', '<cmd>Telescope file_browser<cr>', {})
vim.api.nvim_set_keymap('n', '<leader>gg', '<cmd>Telescope live_grep<cr>', {})
vim.api.nvim_set_keymap('n', '<leader><leader>', '<cmd>Telescope find_files<cr>', {})
vim.api.nvim_set_keymap('n', '<leader>gf', '<cmd>require("telescope.builtins").live_grep {default_text="function"}<cr>', {})
vim.api.nvim_set_keymap('n', '<leader>l', '<cmd>Telescope resume<cr>', {})
vim.api.nvim_set_keymap('n', '<leader>', '<cmd><cr>', {})
vim.api.nvim_set_keymap('n', '<leader>', '<cmd><cr>', {})

vim.api.nvim_set_keymap('n', '<leader>z', '<cmd>lua require("yazi").yazi()<cr>', {})

function coq_panels_picker()
  local telescope = require("telescope")
  local finders = require("telescope.finders")
  local sorters = require("telescope.sorters")
  local actions = require("telescope.actions")
  local action_state = require("telescope.actions.state")

  -- Get all listed buffers, then filter for those whose names match the Coq panel prefix.
  local all_bufs = vim.api.nvim_list_bufs()
  local coq_bufs = vim.tbl_filter(function(buf)
    local name = vim.api.nvim_buf_get_name(buf)
    return name:match("CoqInfoPanel")
  end, all_bufs)

  require('telescope.builtin').buffers({
    prompt_title = "Coq Info Panels",
    finder = finders.new_table {
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
    },
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

vim.api.nvim_set_keymap(
  'n',
  '<leader>bc',
  '<cmd>lua coq_panels_picker()<cr>',
  { noremap = true, silent = true }
)
