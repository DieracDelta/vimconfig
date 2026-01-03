require("lze").load({
  "claudecode-nvim",
  cmd = { "ClaudeCode", "ClaudeCodeFocus", "ClaudeCodeLog" },
  keys = {
    { "<leader>ac", desc = "Toggle Claude" },
    { "<leader>af", desc = "Focus Claude" },
    { "<leader>ar", desc = "Resume Claude" },
    { "<leader>aC", desc = "Continue Claude" },
    { "<leader>am", desc = "Select Claude model" },
    { "<leader>ab", desc = "Add current buffer" },
    { "<leader>as", mode = "v", desc = "Send to Claude" },
    { "<leader>aa", desc = "Accept diff" },
    { "<leader>ad", desc = "Deny diff" },
  },
  after = function()
    require("snacks").setup()
    require("claudecode").setup()

    -- keymaps are handled by lze keys, but we can double check
  end,
})
