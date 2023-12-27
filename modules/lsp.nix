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

  setup.rust-tools = {
    client.server_capabilities.semanticTokensProvider = "nil";
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
    function is_rustc_installed()
        local result = os.execute("which rustc > /dev/null")
        return result == 0
    end
    if is_rustc_installed() then
      local codelldb_bin = "${pkgs.code-lldb}/share/vscode/extensions/vadimcn.vscode-lldb/adapter/codelldb"
      local codelldb_lib = "${pkgs.code-lldb}/share/vscode/extensions/vadimcn.vscode-lldb/lldb/lib/liblldb.dylib"
      -- After extracting cargo's compiler metadata with the cargo inspector
      -- parse it to find the binary to debug
      local function parse_cargo_metadata(cargo_metadata)
        -- Iterate backwards through the metadata list since the binary
        -- we're interested will be near the end (usually second to last)
        for i = 1, #cargo_metadata do
          local json_table = cargo_metadata[#cargo_metadata + 1 - i]

          -- Some metadata lines may be blank, skip those
          if string.len(json_table) ~= 0 then
            -- Each matadata line is a JSON table,
            -- parse it into a data structure we can work with
            json_table = vim.fn.json_decode(json_table)

            -- Our binary will be the compiler artifact with an executable defined
            if json_table["reason"] == "compiler-artifact" and json_table["executable"] ~= vim.NIL then
              return json_table["executable"]
            end
          end
        end

        return nil
      end

      -- Parse the `cargo` section of a DAP configuration and add any needed
      -- information to the final configuration to be handed back to the adapter.
      -- E.g.: When debugging a test, cargo generates a random executable name.
      -- We need to ask cargo for the name and add it to the `program` config field
      -- so LLDB can find it.
      local function cargo_inspector(config)
        local final_config = vim.deepcopy(config)

        -- Create a buffer to receive compiler progress messages
        local compiler_msg_buf = vim.api.nvim_create_buf(false, true)
        vim.api.nvim_buf_set_option(compiler_msg_buf, "buftype", "nofile")

        -- And a floating window in the corner to display those messages
        local window_width = math.max(#final_config.name + 1, 50)
        local window_height = 12
        local compiler_msg_window = vim.api.nvim_open_win(compiler_msg_buf, false, {
          relative = "editor",
          width = window_width,
          height = window_height,
          col = vim.api.nvim_get_option "columns" - window_width - 1,
          row = vim.api.nvim_get_option "lines" - window_height - 1,
          border = "rounded",
          style = "minimal",
        })

        -- Let the user know what's going on
        vim.fn.appendbufline(compiler_msg_buf, "$", "Compiling: ")
        vim.fn.appendbufline(compiler_msg_buf, "$", final_config.name)
        vim.fn.appendbufline(compiler_msg_buf, "$", string.rep("=", window_width - 1))

        -- Instruct cargo to emit compiler metadata as JSON
        local message_format = "--message-format=json"
        if final_config.cargo.args ~= nil then
          table.insert(final_config.cargo.args, message_format)
        else
          final_config.cargo.args = { message_format }
        end

        -- Build final `cargo` command to be executed
        local cargo_cmd = { "cargo" }
        for _, value in pairs(final_config.cargo.args) do
          table.insert(cargo_cmd, value)
        end

        -- Run `cargo`, retaining buffered `stdout` for later processing,
        -- and emitting compiler messages to to a window
        local compiler_metadata = {}
        local cargo_job = vim.fn.jobstart(cargo_cmd, {
          clear_env = false,
          env = final_config.cargo.env,
          cwd = final_config.cwd,

          -- Cargo emits compiler metadata to `stdout`
          stdout_buffered = true,
          on_stdout = function(_, data) compiler_metadata = data end,

          -- Cargo emits compiler messages to `stderr`
          on_stderr = function(_, data)
            local complete_line = ""

            -- `data` might contain partial lines, glue data together until
            -- the stream indicates the line is complete with an empty string
            for _, partial_line in ipairs(data) do
              if string.len(partial_line) ~= 0 then complete_line = complete_line .. partial_line end
            end

            if vim.api.nvim_buf_is_valid(compiler_msg_buf) then
              vim.fn.appendbufline(compiler_msg_buf, "$", complete_line)
              vim.api.nvim_win_set_cursor(compiler_msg_window, { vim.api.nvim_buf_line_count(compiler_msg_buf), 1 })
              vim.cmd "redraw"
            end
          end,

          on_exit = function(_, exit_code)
            -- Cleanup the compile message window and buffer
            if vim.api.nvim_win_is_valid(compiler_msg_window) then
              vim.api.nvim_win_close(compiler_msg_window, { force = true })
            end

            if vim.api.nvim_buf_is_valid(compiler_msg_buf) then
              vim.api.nvim_buf_delete(compiler_msg_buf, { force = true })
            end

            -- If compiling succeeed, send the compile metadata off for processing
            -- and add the resulting executable name to the `program` field of the final config
            if exit_code == 0 then
              local executable_name = parse_cargo_metadata(compiler_metadata)
              if executable_name ~= nil then
                final_config.program = executable_name
              else
                vim.notify(
                  "Cargo could not find an executable for debug configuration:\n\n\t" .. final_config.name,
                  vim.log.levels.ERROR
                )
              end
            else
              vim.notify("Cargo failed to compile debug configuration:\n\n\t" .. final_config.name, vim.log.levels.ERROR)
            end
          end,
        })

        -- Get the rust compiler's commit hash for the source map
        local rust_hash = ""
        local rust_hash_stdout = {}
        local rust_hash_job = vim.fn.jobstart({ "rustc", "--version", "--verbose" }, {
          clear_env = false,
          stdout_buffered = true,
          on_stdout = function(_, data) rust_hash_stdout = data end,
          on_exit = function()
            for _, line in pairs(rust_hash_stdout) do
              local start, finish = string.find(line, "commit-hash: ", 1, true)

              if start ~= nil then rust_hash = string.sub(line, finish + 1) end
            end
          end,
        })

        -- Get the location of the rust toolchain's source code for the source map
        local rust_source_path = ""
        local rust_source_job = vim.fn.jobstart({ "rustc", "--print", "sysroot" }, {
          clear_env = false,
          stdout_buffered = true,
          on_stdout = function(_, data) rust_source_path = data[1] end,
        })

        -- Wait until compiling and parsing are done
        -- This blocks the UI (except for the :redraw above) and I haven't figured
        -- out how to avoid it, yet
        -- Regardless, not much point in debugging if the binary isn't ready yet
        vim.fn.jobwait { cargo_job, rust_hash_job, rust_source_job }

        -- Enable visualization of built in Rust datatypes
        final_config.sourceLanguages = { "rust" }

        -- Build sourcemap to rust's source code so we can step into stdlib
        rust_hash = "/rustc/" .. rust_hash .. "/"
        rust_source_path = rust_source_path .. "/lib/rustlib/src/rust/"
        if final_config.sourceMap == nil then final_config["sourceMap"] = {} end
        final_config.sourceMap[rust_hash] = rust_source_path

        -- Cargo section is no longer needed
        final_config.cargo = nil

        return final_config
      end


      require("dap").adapters.lldb = {
        type = "server",
        port = "1337",
        executable = {
          command = codelldb_bin,
          args = { "--port", "1337", "--liblldb", codelldb_lib },
        },
        enrich_config = function(config, on_config)
          if config["cargo"] ~= nil then on_config(cargo_inspector(config)) end
         end,
      }
      local dap = require("dap")
      local hash = vim.fn.system({ "rustc", "-V", "-v" }):match("commit%-hash%: (%w+)")
      local sysroot = vim.fn.system({ "rustc", "--print", "sysroot" }):match("^%s*(.-)%s*$")
      dap.configurations.rust = {
        {
          type = "lldb",
          request = "launch",
          name = "Launch Program (codelldb)",
          program = function()
            return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
          end,
          cwd = "$${workspaceFolder}",
          terminal = "integrated",
          sourceLanguages = { "rust" },
          sourceMap = { ["/rustc/" .. hash .. "/"] = sysroot .. "/lib/rustlib/src/rust" },
        },
      }
    end



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
              require'rust-tools'.hover_actions.hover_actions()
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
      let save_cursor = getpos('.')
      let save_modified = &modified

      try
        silent execute '%!rustfmt'
        " Check if rustfmt was successful (exit code 0)
        if v:shell_error == 0
          " Success, update cursor position and modified flag
          call setpos('.', save_cursor)
          let modified=0
        else
          echohl WarningMsg | echo "rustfmt encountered an error" | echohl None
        endif
      finally
        " Always restore modified flag
        let &modified = save_modified
      endtry
    endfunction

    autocmd BufWritePre *.rs let b:cursor_save = getpos(".")
    autocmd BufWritePost *.rs call setpos('.', b:cursor_save)
    autocmd BufWritePre *.rs call RustfmtFormat()

  '';

  # assumed brought in by devshell.
  # let g:vimtex_compiler_latexmk = { 'executable' : '${pkgs.texlive}/bin/latexmk', }
}]
