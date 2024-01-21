{ pkgs, dsl, ... }:
with dsl;
let setupCodeium = (if !pkgs.neovimArgs.makeOffline then
{
  # setup.codeium = {
    # tools = {
    #   language_server = builtins.trace "FUUU" "${pkgs.codeium-lsp}/bin/codeium-lsp";
    # };
  # };
} else builtins.trace "NOOO" {});
in
pkgs.lib.mkMerge [
setupCodeium
{
  plugins = with pkgs; [
    vimPlugins.typescript-tools-nvim
    typst-vim
    vimPlugins.vim-ormolu
    vimPlugins.haskell-tools-nvim
    # completion framework
    cmp-nvim-lsp
    nvim-cmp
    vimPlugins.cmp-vsnip
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
    ferris-nvim
    rustaceanvim
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

    codeium-nvim

    # chatgpt-nvim

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

  setup.dapui = {
    controls.icons = {
      disconnect = "Disconnect";
      pause = "⏸️";
      play = "";
      run_last = "Run Last";
      step_back = "Back";
      step_into = "Into";
      step_out = "Out";
      step_over = "Over";
      terminate = "Kill";
    };
    icons = {
      expanded = "▾";
      collapsed = "▸";
      current_frame = "-";
    };
  };

  setup.copilot = {
    suggestion = { enabled = true; };
    panel = { enabled = true; };
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
  #   cmd = ["haskell-language-server" "--lsp"];
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

  use.lspconfig.ltex.setup = callWith {
    cmd = ["${pkgs.ltex-ls}/bin/ltex-ls"];
    language = "en-US";
    settings = {
      ltex = {
        additionalRules = {
          languageModel = "~/ngrams/";
          enablePickyRules = true;
        };
      };
    };
  };

  use.lspconfig.lua_ls.setup = callWith {
    cmd = ["${pkgs.lua-language-server}/bin/lua-language-server"];
    settings = {
      Lua = {
        runtime = {
          version = "LuaJIT";
        };
        diagnostics = {
          globals = rawLua "{\"vim\"}";
        };
        workspace = {
          library = rawLua "vim.api.nvim_get_runtime_file(\"\", true)";
        };
        telemetry = {
          enable = false;
        };
      };
    };
  };

  # use.lspconfig."bsl_ls".setup =
  #   callWith {
  #     cmd = [ "${pkgs.coq-lsp}/bin/coq-lsp" ];
  #     filetypes = [ "coq" "verilog" ];
  #   };

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
      # { name = "codeium"; }
      { name = "nvim_lsp"; }
      { name = "vsnip"; }
      { name = "buffer"; }
      { name = "crates"; }
    ];
    snippet.expand =
      rawLua ''
        function(args)
          vim.fn['vsnip#anonymous'](args.body)
        end
      '';
      # snippet = {
  #   expand = function(args)
  #     vim.fn['vsnip#anonymous'](args.body)
  #   end
  # },
    formatting = {
      format = rawLua ''
      require('lspkind').cmp_format({
        mode = "symbol",
        maxwidth = 50,
        ellipsis_char = '...',
        --
        symbol_map = { Suggestion = "", }
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
    require("dap").adapters.nix = {
      type = "executable",
      command = "/Users/jrestivo/dev/nix-debug-adapter/target_dirs/nix_rustc/release/nix-debug-adapter",
      args = {}
    }


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
              -- technically same as else statement
              -- keeping it here in case I migrate to something else
              -- also don't want to conflict with ferris
              vim.cmd.RustLsp {'hover', 'actions'}
          else
              vim.lsp.buf.hover()
          end
        end
    end

    -- set the target directory to be different/not shared with rustc
    vim.fn.setenv("CARGO_TARGET_DIR", "target_dirs/nix_ra")

    --if os.getenv("OPENAI_API_KEY") ~= nil then
    --  require("chatgpt").setup({  })
    --end



      require("cmp").setup.filetype({ "dap-repl", "dapui_watches", "dapui_hover" }, {
        sources = {
          { name = "dap" },
        },
      })
    local dap = require("dap")

    dap.configurations.nix = {{
      type = "nix",
      request = "launch",
      name = "Launch Program (nix debug adapter)",
      program = function()
        return vim.fn.input("Path to nix file to evaluate: ", vim.fn.getcwd() .. "/", "file")
      end,
      attribute = function()
        return vim.fn.input("Attribute to evaluate: ")
      end,
      cwd = "$${workspaceFolder}",
      terminal = "integrated",
      sourceLanguages = { "nix" },
    }}
      vim.api.nvim_set_hl(0, 'DapBreakpoint', { ctermbg = 0, fg = '#993939', bg = '#31353f' })
      vim.api.nvim_set_hl(0, 'DapLogPoint', { ctermbg = 0, fg = '#61afef', bg = '#31353f' })
      vim.api.nvim_set_hl(0, 'DapStopped', { ctermbg = 0, fg = '#98c379', bg = '#31353f' })
      vim.fn.sign_define('DapBreakpoint', { text='', texthl='DapBreakpoint', linehl='DapBreakpoint', numhl='DapBreakpoint' })
      vim.fn.sign_define('DapBreakpointCondition', { text='ﳁ', texthl='DapBreakpoint', linehl='DapBreakpoint', numhl='DapBreakpoint' })
      vim.fn.sign_define('DapBreakpointRejected', { text='', texthl='DapBreakpoint', linehl='DapBreakpoint', numhl= 'DapBreakpoint' })
      vim.fn.sign_define('DapLogPoint', { text='', texthl='DapLogPoint', linehl='DapLogPoint', numhl= 'DapLogPoint' })
      vim.fn.sign_define('DapStopped', { text='', texthl='DapStopped', linehl='DapStopped', numhl= 'DapStopped' })


      require('haskell-tools')
      require('telescope').load_extension('ht')
      require'lspconfig'.typst_lsp.setup{}
      require("typescript-tools").setup {
        tsserver_path = "./node_modules/typescript/lib/",
      }
      require('ferris').setup({})
   '';

  # todo these are all globals...
  # move to vim.g
  vimscript = ''
    let g:tex_flavor='latex'
    let g:vimtex_view_method='zathura'
    let g:vimtex_quickfix_mode=0
    set conceallevel=1
    let g:tex_conceal='abdmg'
    let g:vimtex_compiler_latexmk = { 'options' : [ 'notes.tex', '-shell-escape', '-interaction=nonstopmode' ] }
    let g:vimtex_complete_enabled = 1
    let g:vimtex_complete_close_braces = 1
    let g:vimtex_complete_ignore_case = 1
    let g:vimtex_complete_smart_case = 1


    let g:vsnip_snippet_dir='~/.vsnip/'

    function! RustfmtFormat()
    endfunction

    autocmd BufWritePre *.rs let b:cursor_save = getpos(".")
    autocmd BufWritePost *.rs call setpos('.', b:cursor_save)
    autocmd BufWritePre *.rs call RustfmtFormat()

  '';

  # assumed brought in by devshell.
  # let g:vimtex_compiler_latexmk = { 'executable' : '${pkgs.texlive}/bin/latexmk', }
}]
