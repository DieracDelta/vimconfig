{ pkgs, dsl, ... }:
with dsl; {
  plugins = with pkgs; [
    # dependency for nvim-ufo
    nvim-async
    # folding with treesitter and lsp
    nvim-ufo
    # commenting with treesiter
    comment-nvim
    # which method am I on
    vimPlugins.nvim-treesitter-context
    vimPlugins.nvim-treesitter-textobjects
    ((pkgs.vimPlugins.nvim-treesitter.overrideAttrs (oldAttrs: {
      src = nvim-treesitter-src;
    }) ).withAllGrammars)
    # auto open/close html tags with treesitter
    vimPlugins.nvim-ts-autotag
    # highlighted parens
    vimPlugins.rainbow-delimiters-nvim
    # toggle btwn all the things with %
    nvim-matchup
    # highlight other occurrences of a phrase
    vim-illuminate
    markid
    # provides node action
    ts-node-action
  ];

  setup.ts-node-action = {};

  use.Comment.setup = callWith {
    toggler = {
      line = "<leader>c<leader>";
      block = "<leader>b<leader>";
    };
    opleader = {
      line = "<leader>c";
      block = "<leader>b";
    };
    extra = {
      above = "<leader>cO";
      below = "<leader>co";
      eol = "<leader>cA";
    };
  };

  use."nvim-treesitter.configs".setup = callWith {
    ensure_installed = {};
    markid = { enable = true; };
    highlight = {
      enable = true;
      use_languagetree = true;
      # TODO why?
      disable = [ "css" ];
      additional_vim_regex_highlighting = true;
    };
    ignore = ["QuickScopePrimary" "QuickScopeSecondary"];
    incremental_selection = {
      enable = true;
      keymaps = {
        init_selection = "<C-n>";
        node_incremental = "<C-n>";
        scope_incremental = "<C-s>";
        node_decremental = "<C-p>";
      };
    };
    # indent.enable = true;
    rainbow = {
      enable = true;
      disable = [ "html" ];
      extended_mode = true;
      max_file_lines = 10000;
      colors = [
        "#bd93f9"
        "#6272a4"
        "#8be9fd"
        "#50fa7b"
        "#f1fa8c"
        "#ffb86c"
        "#ff5555"
      ];
    };
    textobjects = {
      select = {
        enable = true;
        lookahead = true;

        keymaps = {
          # functions
          "['tfo']" = "@function.outer";
          "['tfi']" = "@function.inner";
          # classes
          "['tco']" = "@class.outer";
          "['tci']" = "@class.inner";
          # boolean
          "['too']" = "@conditional.outer";
          "['toi']" = "@conditional.inner";
          # comment "useless"
          "['tuo']" = "@comment.outer";
          "['tui']" = "@comment.inner";
          # param
          "['tpo']" = "@param.outer";
          "['tpi']" = "@param.inner";
          # loop
          "['tlo']" = "@loop.outer";
          "['tli']" = "@loop.inner";
          # block
          "['tbo']" = "@block.outer";
          "['tbi']" = "@block.inner";
          # statement (expression, bad use of e, agreed)
          "['teo']" = "@statement.outer";
          "['tei']" = "@statement.inner";
        };
      };
      move = {
        enable = true;
        set_jumps = true; # whether to set jumps in the jumplist
        goto_next_start = {
          "['tmf']" = "@function.outer";
          "['tmc']" = "@class.outer";
          "['tmo']" = "@conditional.outer";
          "['tmu']" = "@comment.outer";
          "['tmp']" = "@param.outer";
          "['tml']" = "@loop.outer";
          "['tmb']" = "@block.outer";
          "['tms']" = "@statement.outer";
        };
        goto_next_end = {
          "['tmF']" = "@function.outer";
          "['tmC']" = "@class.outer";
          "['tmO']" = "@conditional.outer";
          "['tmU']" = "@comment.outer";
          "['tmP']" = "@param.outer";
          "['tmL']" = "@loop.outer";
          "['tmB']" = "@block.outer";
          "['tmS']" = "@statement.outer";
        };
        goto_previous_start = {
          "['tMf']" = "@function.outer";
          "['tMc']" = "@class.outer";
          "['tMo']" = "@conditional.outer";
          "['tMu']" = "@comment.outer";
          "['tMp']" = "@param.outer";
          "['tMl']" = "@loop.outer";
          "['tMb']" = "@block.outer";
          "['tMs']" = "@statement.outer";
        };
        goto_previous_end = {
          "['tMF']" = "@function.outer";
          "['tMC']" = "@class.outer";
          "['tMO']" = "@conditional.outer";
          "['tMU']" = "@comment.outer";
          "['tMP']" = "@param.outer";
          "['tML']" = "@loop.outer";
          "['tMB']" = "@block.outer";
          "['tMS']" = "@statement.outer";
        };
      };
      swap = {
        enable = true;
        swap_next = {
          "['tsf']" = "@function.outer";
          "['tsc']" = "@class.outer";
          "['tso']" = "@conditional.outer";
          "['tsu']" = "@comment.outer";
          "['tsp']" = "@param.outer";
          "['tsl']" = "@loop.outer";
          "['tsb']" = "@block.outer";
          "['tss']" = "@statement.outer";
        };
        swap_previous = {
          "['tSf']" = "@function.outer";
          "['tSc']" = "@class.outer";
          "['tSo']" = "@conditional.outer";
          "['tSu']" = "@comment.outer";
          "['tSp']" = "@param.outer";
          "['tSl']" = "@loop.outer";
          "['tSb']" = "@block.outer";
          "['tSs']" = "@statement.outer";
        };
      };
      lsp_interop = {
        enable = true;
        border = "none";
        peek_definition_code = {
          "['<leader>df']" = "@function.outer";
          "['<leader>dF']" = "@class.outer";
        };
      };
    };
    # TODO treesitter issue, wait until better ts
    matchup.enable = true;
    autotag.enable = true;
  };

  lua = ''
    -- default configuration
    require('illuminate').configure({
        -- providers: provider used to get references in the buffer, ordered by priority
        providers = {
            'lsp',
            'treesitter',
            'regex',
        },
        -- delay: delay in milliseconds
        delay = 100,
        -- under_cursor: whether or not to illuminate under the cursor
        under_cursor = true,
    })
    require('illuminate').resume()

    -- Using ufo provider need remap `zR` and `zM`
    vim.keymap.set('n', 'zR', require('ufo').openAllFolds)
    vim.keymap.set('n', 'zM', require('ufo').closeAllFolds)
    require('ufo').setup({
      preview = {
          mappings = {
              scrollU = 'k',
              scrollD = 'j'
          }
      },
      provider_selector = function(bufnr, filetype, buftype)
          return {'treesitter', 'indent'}
      end
    })
  '';
}
