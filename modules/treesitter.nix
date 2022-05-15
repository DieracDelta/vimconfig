{ pkgs, dsl, ... }:
with dsl; {
  plugins = with pkgs; [
    # commenting with treesiter
    comment-nvim
    # which method am I on
    vimPlugins.nvim-treesitter-context
    vimPlugins.nvim-treesitter-textobjects
    (pkgs.vimPlugins.nvim-treesitter.withPlugins
      # tree sitter with language support
      (plugins:
        with plugins; [
          tree-sitter-nix
          tree-sitter-rust
          tree-sitter-json
          tree-sitter-c
          tree-sitter-go
          tree-sitter-hcl
        ]))
    # auto open/close html tags with treesitter
    vimPlugins.nvim-ts-autotag
    # highlighted parens
    vimPlugins.nvim-ts-rainbow
    # toggle btwn all the things with %
    vimPlugins.vim-matchup
  ];

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
    ensure_installed = [ "nix" "rust" ];
    highlight = {
      enable = true;
      use_languagetree = true;
      # TODO why?
      disable = [ "css" ];
    };
    incremental_selection = {
      enable = true;
      keymaps = {
        init_selection = "<C-n>";
        node_incremental = "<C-n>";
        scope_incremental = "<C-s>";
        node_decremental = "<C-p>";
      };
    };
    indent.enable = true;
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
          "['af']" = "@function.outer";
          "['if']" = "@function.inner";
          "['ac']" = "@class.outer";
          "['ic']" = "@class.inner";
        };
      };
    };
    matchup.enable = true;
    autotag.enable = true;
  };
}
