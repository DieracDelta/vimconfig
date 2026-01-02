require("lze").load({
  "typescript-tools-nvim",
  ft = { "typescript", "javascript", "typescriptreact", "javascriptreact" },
  after = function()
    require("typescript-tools").setup({
      tsserver_path = "./node_modules/typescript/lib/",
    })
    
    vim.api.nvim_set_keymap("n", "<leader>na", '<cmd>lua require("ts-node-action").node_action({})<cr>', {})
  end,
})
