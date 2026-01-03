require("lze").load({
  "conform.nvim",
  event = { "BufWritePre" },
  cmd = { "FormatDisable", "FormatEnable", "ConformInfo" },
  keys = {
    { "<leader>f", desc = "Format" },
  },
  after = function()
    require("conform").setup({
      formatters_by_ft = {
        nix = { "nixfmt" },
        gofmt = { "gofmt" },
        ruff_format = { "ruff" },
        lua = { "stylua" },
        rustfmt = { "rustfmt" },
        shellcheck = { "shellcheck" },
        shfmt = { "shfmt" },
        just = { "just" },
        typst = { "prettypst" },
        html = { "prettierd" },
        ocaml = { "ocamlformat" },
        haskell = { "fourmolu" },
      },
      format_on_save = function(bufnr)
        if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
          return
        end
        return { timeout_ms = 500, lsp_format = "fallback" }
      end,
    })

    vim.api.nvim_create_user_command("FormatDisable", function(args)
      if args.bang then
        vim.b.disable_autoformat = true
      else
        vim.g.disable_autoformat = true
      end
    end, {
      desc = "Disable autoformat-on-save",
      bang = true,
    })
    vim.api.nvim_create_user_command("FormatEnable", function()
      vim.b.disable_autoformat = false
      vim.g.disable_autoformat = false
    end, {
      desc = "Re-enable autoformat-on-save",
    })
    
    -- This keymap was in lsp.lua pointing to lsp formatting, but conform usually replaces it
    vim.api.nvim_set_keymap("n", "<leader>f", "<cmd>lua require('conform').format({ lsp_fallback = true })<cr>", {})
  end,
})
