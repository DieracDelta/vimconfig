require("lze").load({
  "crates.nvim",
  event = { "BufRead Cargo.toml" },
  after = function()
    require("crates").setup({
      text = {
        loading = "  Loading...",
        version = "  %s",
        prerelease = "  %s",
        yanked = "  %s yanked",
        nomatch = "  Not found",
        upgrade = "  %s",
        error = "  Error fetching crate",
      },
      popup = {
        text = {
          title = " # %s ",
          version = " %s ",
          prerelease = " %s ",
          yanked = " %s yanked ",
          feature = "   %s ",
          enabled = " * %s ",
          transitive = " ~ %s ",
        },
      },
    })
    
    vim.api.nvim_set_keymap("n", "<leader>cu", '<cmd>lua require("crates").update_crate()<cr>', {})
    vim.api.nvim_set_keymap("n", "<leader>cua", '<cmd>lua require("crates").update_all_crate()<cr>', {})
    vim.api.nvim_set_keymap("n", "<leader>cU", '<cmd>lua require("crates").upgrade_crate()<cr>', {})
    vim.api.nvim_set_keymap("n", "<leader>cUa", '<cmd>lua require("crates").upgrade_all_crate()<cr>', {})
  end,
})
