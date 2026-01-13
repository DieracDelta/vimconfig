require("lze").load({
  "coq-lsp-nvim",
  ft = { "coq" },
  after = function()
    -- Load coqtail for syntax highlighting (it's in opt plugins)
    vim.g["coqtail#supported"] = 0  -- Disable interactive features
    vim.cmd("packadd coqtail")
    -- Re-trigger syntax loading for the current buffer
    vim.cmd("doautocmd Syntax")

    require("coq-lsp").setup()
    
    -- telescope picker for coq panels (moved from telescope.lua as it seems coq specific)
    -- Actually, the picker function `coq_panels_picker` was defined in telescope.lua.
    -- I should probably leave it there or move it here if I can lazy load it.
    -- For now I'll leave the picker in telescope.lua but maybe the keymap here?
    -- The user had <leader>bc mapped to it.
  end,
})
