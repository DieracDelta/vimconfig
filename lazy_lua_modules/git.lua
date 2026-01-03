local lze = require("lze")

lze.load({
  "blamer-nvim",
  cmd = { "BlamerToggle" },
  keys = {
    { "<leader>gb", "<cmd>BlamerToggle<cr>", desc = "Git Blame Toggle" },
  },
  load = function(name)
    vim.cmd("packadd " .. name)
  end,
  after = function()
    require('blamer').setup({
      date_format = "%m-%d-%Y %H:%M",
      window_width = 40,
      show_summary = true
    })
    vim.g.blamer_show_in_insert_modes = 0
    vim.g.blamer_ignored_filetypes = { 'TelescopePrompt', 'TelescopeResults' }
    
    vim.api.nvim_set_keymap('n', '<leader>gb', '<cmd>BlamerToggle<cr>', {})
  end,
})

-- Neogit manual lazy load to avoid lz/keys issues
local neogit_loaded = false
local function load_neogit()
  if neogit_loaded then return end
  vim.cmd("packadd neogit")
  require("neogit").setup({
    signs = {
      section = { "", "" },
      item = { "", "" },
      hunk = { "", "" },
    },
  })
  neogit_loaded = true
end

vim.keymap.set('n', '<leader>gs', function()
  load_neogit()
  require("neogit").open()
end, { desc = "Neogit" })
