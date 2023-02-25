{ pkgs, dsl, ... }:
with dsl; {
  plugins = with pkgs; [
    # completion framework
    cmp-nvim-lsp
    nvim-cmp
    cmp-buffer
    # lsp things
    vimPlugins.lsp_signature-nvim
    vimPlugins.lspkind-nvim
    lsp-config
    # utility functions for lsp
    # vimPlugins.plenary-nvim
    plenary-nvim
    # popout for documentation
    vimPlugins.popup-nvim
    # snippets funcitonality
    vimPlugins.vim-vsnip
    vimPlugins.vim-vsnip-integ
    # snippets lists
    vimPlugins.friendly-snippets
    # more lsp rust functionality
    rust-tools
    # for updating rust crates
    vimPlugins.crates-nvim
    # texx
    vimPlugins.vimtex
    # for showing lsp progress
    fidget
    # for diagnostics/quickfix window
    vimPlugins.trouble-nvim

    # for lean support
    # vimPlugins.lean-nvim

    # lsp_lines
    copilot-lua
    copilot-cmp

    # neural
    nui-nvim
    # significant-nvim

    codium-nvim

    chatgpt-nvim

    nvim-dap

    nvim-dap-virtual-text

    nvim-dap-ui

    cmp-dap

    node-type-nvim

    floating-input

  ];

  setup.node-type = {};

  setup.floating-input = {};


  setup.nvim-dap-virtual-text = {};

  setup.dapui = {};

  setup.codeium = {
    tools = {
      language_server = "${pkgs.codium-lsp}/bin/language_server";
    };
  };

  setup.copilot = {
    suggestion = { enabled = false; };
    panel = { enabled = false; };
  };

  setup.copilot_cmp = {
    method = "getCompletionsCycling";
    formatters = {
      insert_text = rawLua "require(\"copilot_cmp.format\").remove_existing";
    };
  };

  setup.fidget = { };

  # setup.chatgpt = { };

  # setup.lsp_lines = { };

  setup.rust-tools = {
    server = {
      # settings = { "[\"rust-analyzer\"]" = { cargo.features = rawLua "os.getenv(\"NVIM_RUST_ENABLED_FEATURE_FLAGS\") and { os.getenv(\"NVIM_RUST_ENABLED_FEATURE_FLAGS\") } or \"all\"" ;
      settings = { "[\"rust-analyzer\"]" = { cargo.features = rawLua "loadfile(\".nvim/example.env.lua\") and { loadfile(\".nvim/example.env.lua\")() } or \"all\"" ;
      };
      };
    };
    tools = {
      autoSetHints = true;
      runnables = { use_telescope = true; };
      inlay_hints = {

        only_current_line = false;
        only_current_line_autocmd = "CursorMoved";

        show_parameter_hints = true;

        parameter_hints_prefix = "<- ";
        other_hints_prefix = "=> ";

        max_len_align = false;

        max_len_align_padding = 1;

        right_align = false;

        right_align_padding = 7;
        highlight = "DiagnosticSignWarn";
      };
    };
    dap = {
    # TODO this will need to be different on linux
      adapter = rawLua "require(\"rust-tools.dap\").get_codelldb_adapter(\"${pkgs.code-lldb}/share/vscode/extensions/vadimcn.vscode-lldb/adapter/codelldb\", \"${pkgs.code-lldb}/share/vscode/extensions/vadimcn.vscode-lldb/lldb/lib/liblldb.dylib\")";
    };
  };

  setup.crates = {
    text = {
      loading = "  Loading...";
      version = "  %s";
      prerelease = "  %s";
      yanked = "  %s yanked";
      nomatch = "  Not found";
      upgrade = "  %s";
      error = "  Error fetching crate";
    };
    popup = {
      text = {
        title = " # %s ";
        version = " %s ";
        prerelease = " %s ";
        yanked = " %s yanked ";
        feature = "   %s ";
        enabled = " * %s ";
        transitive = " ~ %s ";
      };
    };
    cmp = {
      text = {
        prerelease = " pre-release ";
        yanked = " yanked ";
      };
    };
  };

  # brocken on macos. TODO probably could add conditional
  # use.lspconfig.hls.setup = callWith {
  #   cmd = ["${pkgs.haskell-language-server}/bin/haskell-language-server" "lsp"];
  # };

  # defaults are good enough for now
  use.trouble.setup = callWith { };

  use.lspconfig.pyright.setup =
    callWith { cmd = [ "${pkgs.pyright}/bin/pyright-langserver" "--stdio" ]; };
  use.lspconfig.terraformls.setup =
    callWith { cmd = [ "${pkgs.terraform-ls}/bin/terraform-lsp" ]; };
  use.lspconfig.rnix.setup = callWith {
    autostart = true;
    cmd = [ "${pkgs.nil}/bin/nil" ];
    capabilities = rawLua
      "require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())";
  };

  use.lspconfig."bsl_ls".setup =
    callWith {
      cmd = [ "${pkgs.coq-lsp}/bin/coq-lsp" ];
      filetypes = [ "coq" "verilog" ];
    };

  # use.lspconfig.rust_analyzer.setup = callWith {
  #   # assumed to be provided by the project's nix-shell
  #   cmd = [ "rust-analyzer" ];
  #   capabilities = rawLua
  #     "require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())";
  #   settings = { "['rust-analyzer']" = { procMacro = { enable = true; }; }; };
  # };

  use.lspconfig.clangd.setup =
    callWith { cmd = [ "${pkgs.clang-tools}/bin/clangd" ]; };

  use.lspconfig.texlab.setup =
    callWith { cmd = [ "${pkgs.texlab}/bin/texlab" ]; };

  use.lspconfig.gopls.setup = callWith { cmd = [ "${pkgs.gopls}/bin/gopls" ]; };

  use.lspconfig.r_language_server.setup = callWith { cmd = [ "${pkgs.myRSetup}/bin/R" "--slave" "-e" "languageserver::run()" ]; };

  use.lsp_signature.setup = callWith {
    bind = true;
    hint_enable = false;
    hi_parameter = "Visual";
    handler_opts.border = "single";
  };



  use.cmp.setup = callWith {
    mapping = {
      "['<C-n>']" = rawLua
        "require('cmp').mapping.select_next_item({ behavior = require('cmp').SelectBehavior.Insert })";
      "['<C-p>']" = rawLua
        "require('cmp').mapping.select_prev_item({ behavior = require('cmp').SelectBehavior.Insert })";
      "['<Down>']" = rawLua
        "require('cmp').mapping.select_next_item({ behavior = require('cmp').SelectBehavior.Select })";
      "['<Up>']" = rawLua
        "require('cmp').mapping.select_prev_item({ behavior = require('cmp').SelectBehavior.Select })";
      "['<C-d>']" = rawLua "require('cmp').mapping.scroll_docs(-4)";
      "['<C-f>']" = rawLua "require('cmp').mapping.scroll_docs(4)";
      "['<C-Space>']" = rawLua "require('cmp').mapping.complete()";
      "['<C-e>']" = rawLua "require('cmp').mapping.close()";
      "['<CR>']" = rawLua
        "require('cmp').mapping.confirm({ behavior = require('cmp').ConfirmBehavior.Replace, select = true, })";
    };
    sources = [
      { name = "copilot"; }
      { name = "codeium"; }
      { name = "nvim_lsp"; }
      { name = "buffer"; }
      { name = "vsnip"; }
      { name = "crates"; }
    ];
    snippet.expand =
      rawLua ''function(args) vim.fn["vsnip#anonymous"](args.body) end '';
    formatting = {
      format = rawLua ''
      require('lspkind').cmp_format({
        mode = "symbol",
        maxwidth = 50,
        ellipsis_char = '...',
        --
        symbol_map = { Copilot = "", Suggestion = "", }
      })
    '';
    };
    enabled = rawLua "
      function()
        return vim.api.nvim_buf_get_option(0, \"buftype\") ~= \"prompt\"
            or require(\"cmp_dap\").is_dap_buffer()
      end
    ";
  };





  lua = ''
    local util = require 'lspconfig.util'
    require'lspconfig'.efm.setup {
      cmd = { '/Users/jrestivo/dev/tree-sitter/tree-sitter-riscv-asm/target_dirs/nix_rustc/release/lsp' },
      filetypes = { 'asm' },
      root_dir = function(fname)
        return util.find_git_ancestor(fname) or vim.loop.os_homedir()
      end,
      settings = {},
      init_options = {},

    }


    vim.api.nvim_set_keymap("i", "<Tab>", "vsnip#available(1)  ? '<Plug>(vsnip-jump-next)': '<Tab>'", {expr = true})
    vim.api.nvim_set_keymap("s", "<Tab>", "vsnip#available(1)  ? '<Plug>(vsnip-jump-next)': '<Tab>'", {expr = true})
    vim.api.nvim_set_keymap("i", "<S-Tab>", "vsnip#available(-1)  ? '<Plug>(vsnip-jump-prev)': '<S-Tab>'", {expr = true})
    vim.api.nvim_set_keymap("s", "<S-Tab>", "vsnip#available(-1)  ? '<Plug>(vsnip-jump-prev)': '<S-Tab>'", {expr = true})
    vim.api.nvim_set_keymap("i", "<C-j>", "vsnip#available(1)  ? '<Plug>(vsnip-expand-or-jump)' : '<C-j>'", {expr = true})
    vim.api.nvim_set_keymap("s", "<C-j>", "vsnip#available(1)  ? '<Plug>(vsnip-expand-or-jump)' : '<C-j>'", {expr = true})

    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities.textDocument.completion.completionItem.snippetSupport = true

    require'lspconfig'.jsonls.setup {
      cmd = { '${pkgs.nodePackages.vscode-json-languageserver}/bin/vscode-json-languageserver', '--stdio'},
      capabilities = capabilities,
    }
    function show_documentation()
        local winid = require('ufo').peekFoldedLinesUnderCursor()
        if not winid then
          local filetype = vim.bo.filetype
          if vim.tbl_contains({ 'vim','help' }, filetype) then
              vim.cmd('h '..vim.fn.expand('<cword>'))
          elseif vim.tbl_contains({ 'man' }, filetype) then
              vim.cmd('Man '..vim.fn.expand('<cword>'))
          elseif vim.fn.expand('%:t') == 'Cargo.toml' then
              require('crates').show_popup()
          elseif string.match(filetype, 'rust') == "rust" then
              require'rust-tools'.hover_actions.hover_actions()
          else
              vim.lsp.buf.hover()
          end
        end
    end

    -- set the target directory to be different/not shared with rustc
    vim.fn.setenv("CARGO_TARGET_DIR", "target_dirs/nix_ra")

    -- lean specific on_attach function
     -- local function on_attach(_, bufnr)
     --     local function cmd(mode, lhs, rhs)
     --       vim.keymap.set(mode, lhs, rhs, { noremap = true, buffer = true })
     --     end

     --     -- Autocomplete using the Lean language server
     --     vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
     -- end

    -- no longer needed b/c lsp_lines
    -- vim.diagnostic.Config({ virtual_text = false, })

    --local f = assert(io.open(os.getenv("HOME") .. "/OPENAISECRETKEY", "rb"))
    --local sekritkey = f:read("*all")
    --f:close()
    --vim.fn.setenv("OPENAI_API_KEY", sekritkey)
    require("chatgpt").setup({  })



    --require('neural').setup({
    --    open_ai = {
    --        api_key = content,
    --    }
    --})

      require("cmp").setup.filetype({ "dap-repl", "dapui_watches", "dapui_hover" }, {
        sources = {
          { name = "dap" },
        },
      })

   '';

  # todo these are all globals...
  # move to vim.g
  vimscript = ''
    let g:tex_flavor='latex'
    let g:vimtex_view_method='zathura'
    let g:vimtex_quickfix_mode=0
    set conceallevel=1
    let g:tex_conceal='abdmg'
    let g:vimtex_compiler_latexmk = { 'options' : [ 'main.tex', '-shell-escape', '-interaction=nonstopmode' ] }
    let g:vimtex_complete_enabled = 1
    let g:vimtex_complete_close_braces = 1
    let g:vimtex_complete_ignore_case = 1
    let g:vimtex_complete_smart_case = 1
  '';

  # assumed brought in by devshell.
  # let g:vimtex_compiler_latexmk = { 'executable' : '${pkgs.texlive}/bin/latexmk', }
}
