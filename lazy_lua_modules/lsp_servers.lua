local lze = require("lze")

vim.filetype.add({
  extension = {
    cbl = "cobol",
    cob = "cobol",
    cobol = "cobol",
    jcl = "jcl",
    pli = "pli",
    pl1 = "pli",
    hlasm = "hlasm",
    asm = "hlasm",
    mac = "hlasm",
    s = "hlasm",
  },
})

local function resolve_ironmain_bin()
  local env_bin = vim.env.IRONMAIN_BIN
  if env_bin and env_bin ~= "" then
    return env_bin
  end

  if vim.fn.executable("ironmain") == 1 then
    return "ironmain"
  end

  return "/home/jrestivo/IronMain.workspace/.worktrees/feature-whereareweat/ironmain/target/release/ironmain"
end

local function resolve_ironmain_root(source)
  if type(source) == "number" then
    local name = vim.api.nvim_buf_get_name(source)
    if name == "" then
      return nil
    end
    return vim.fs.root(source, { "Cargo.toml", ".git" }) or vim.fs.dirname(name)
  end

  if type(source) == "string" and source ~= "" then
    return vim.fs.root(source, { "Cargo.toml", ".git" }) or vim.fs.dirname(source)
  end

  return nil
end

local function attach_ironmain_to_existing_buffers(config)
  for _, bufnr in ipairs(vim.api.nvim_list_bufs()) do
    if vim.bo[bufnr].buftype == "" and vim.tbl_contains(config.filetypes, vim.bo[bufnr].filetype) then
      local fname = vim.api.nvim_buf_get_name(bufnr)
      if fname ~= "" then
        local start_config = vim.deepcopy(config)
        start_config.root_dir = resolve_ironmain_root(bufnr)
        vim.lsp.start(start_config, {
          bufnr = bufnr,
          silent = true,
        })
      end
    end
  end
end

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

-- IronMain mainframe LSP
lze.load({
  "ironmain",
  ft = { "cobol", "jcl", "pli", "hlasm" },
  after = function()
    local ironmain_bin = resolve_ironmain_bin()

    if vim.fn.executable(ironmain_bin) == 0 and vim.uv.fs_stat(ironmain_bin) == nil then
      vim.schedule(function()
        vim.notify(
          "IronMain binary not found: " .. ironmain_bin ..
          ". Build /home/jrestivo/IronMain.workspace/.worktrees/feature-whereareweat/ironmain with cargo build -p ironmain-cli --release or set $IRONMAIN_BIN.",
          vim.log.levels.WARN
        )
      end)
    end

    vim.lsp.config("ironmain", {
      cmd = { ironmain_bin, "lsp", "stdio" },
      filetypes = { "cobol", "jcl", "pli", "hlasm" },
      root_dir = function(bufnr, on_dir)
        on_dir(resolve_ironmain_root(bufnr))
      end,
      single_file_support = true,
    })
    vim.lsp.enable("ironmain")
    attach_ironmain_to_existing_buffers(vim.lsp.config.ironmain)
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
