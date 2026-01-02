local lze = require("lze")

-- Terraform
lze.load({
  "terraformls", -- Virtual name, not a plugin name
  ft = { "terraform", "tf" },
  after = function()
    vim.lsp.config("terraformls", {
      cmd = { "terraform-lsp" },
    })
    vim.lsp.enable("terraformls")
  end,
})

-- Lua
lze.load({
  "lua_ls",
  ft = { "lua" },
  after = function()
    vim.lsp.config("lua_ls", {
      cmd = { "lua-language-server" },
      settings = {
        Lua = {
          runtime = {
            version = "LuaJIT",
          },
          diagnostics = {
            globals = { "vim" },
          },
          workspace = {
            library = vim.api.nvim_get_runtime_file("", true),
            checkThirdParty = false,
          },
          telemetry = {
            enable = false,
          },
        },
      },
    })
    vim.lsp.enable("lua_ls")
  end,
})

-- C/C++
lze.load({
  "clangd",
  ft = { "c", "cpp", "objc", "objcpp" },
  after = function()
    vim.lsp.config("clangd", {
      cmd = { "clangd" },
    })
    vim.lsp.enable("clangd")
  end,
})

-- Go
lze.load({
  "gopls",
  ft = { "go", "gomod" },
  after = function()
    vim.lsp.config("gopls", {
      cmd = { "gopls" },
    })
    vim.lsp.enable("gopls")
  end,
})

-- R
lze.load({
  "r_language_server",
  ft = { "r", "rmd" },
  after = function()
    vim.lsp.config("r_language_server", {
      cmd = { "R", "--slave", "-e", "langaugeserver::run()" },
    })
    vim.lsp.enable("r_language_sever")
  end,
})

-- OCaml
lze.load({
  "ocamllsp",
  ft = { "ocaml" },
  after = function()
    vim.lsp.config("ocamllsp", {
      cmd = { "ocamllsp", "--fallback-read-dot-merlin" },
    })
    vim.lsp.enable("ocamllsp")
    
    vim.api.nvim_create_autocmd({ "BufWritePost" }, {
      pattern = { "*.ml", "*.mli" },
      callback = function()
        vim.wo.foldenable = false
      end,
    })
  end,
})

-- Nix
lze.load({
  "nil_ls",
  ft = { "nix" },
  after = function()
    vim.lsp.config("nil_ls", {
      settings = {
        ["nil"] = {
          nix = {
            flake = {
              autoArchive = false,
              autoEvalInputs = false,
            },
          },
        },
      },
    })
    vim.lsp.enable("nil_ls")
  end,
})

-- Python (Ruff)
lze.load({
  "ruff",
  ft = { "python" },
  after = function()
    vim.lsp.config("ruff", {
      init_options = {
        settings = {},
      },
    })
    vim.lsp.enable("ruff")
  end,
})

-- Python (Ty - assuming it's for python or similar, based on previous file)
lze.load({
  "ty",
  ft = { "python" }, -- Assuming python, if not I can adjust
  after = function()
    vim.lsp.config("ty", {})
    vim.lsp.enable("ty")
  end,
})

-- Just
lze.load({
  "just",
  ft = { "just" },
  after = function()
    vim.lsp.config("just", {})
    vim.lsp.enable("just")
  end,
})

-- Typst
lze.load({
  "tinymist",
  ft = { "typst" },
  after = function()
    vim.lsp.enable("tinymist")
    require("image").setup({})
    vim.g.typst_cmd = "typst"
    vim.g.typst_pdf_viewer = "zathura"
    vim.g.typst_conceal = true
    
    vim.api.nvim_create_autocmd("FileType", {
      pattern = "typst",
      callback = function()
        vim.b.lsp_signature_enabled = false
      end,
    })
    
    vim.api.nvim_set_keymap("n", "<leader>mb", "<cmd>TypstWatch<cr>", {})
  end,
})

-- JSON
lze.load({
    "jsonls",
    ft = { "json", "jsonc" },
    after = function()
        local capabilities = vim.lsp.protocol.make_client_capabilities()
        capabilities.textDocument.completion.completionItem.snippetSupport = true

        vim.lsp.config("jsonls", {
          cmd = { "vscode-json-language-server", "--stdio" },
          capabilities = capabilities,
        })
        vim.lsp.enable("jsonls")
    end
})
