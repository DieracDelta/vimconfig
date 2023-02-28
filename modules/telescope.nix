{ pkgs, dsl, ... }:
with dsl; {
  plugins = with pkgs; [
    # fuzzy finder
    telescope-nvim
    vimPlugins.telescope-file-browser-nvim
    # sexy dropdown
    telescope-ui-select
    # dap support
    telescope-dap-nvim
    # dapzzzz
    telescope-dapzzzz
  ];

  lua = ''
    require("telescope").setup {
      defaults = {
        file_ignore_patterns = { "node_modules", "target", "target_dirs" },
        prompt_prefix = "   ",
        selection_caret = "  ",
        entry_prefix = "  ",
        borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
        vimgrep_arguments = {
          "${pkgs.ripgrep}/bin/rg",
          "--color=never",
          "--no-heading",
          "--with-filename",
          "--line-number",
          "--column",
          "--smart-case",
        },
      },
      extensions = {
        ["ui-select"] = {
          require("telescope.themes").get_dropdown {
            -- even more opts
          }
        }
      }
    }
    require("telescope").load_extension("file_browser")
    require("telescope").load_extension("ui-select")
    require('telescope').load_extension('dap')
    require('telescope').load_extension('i23')
  '';

  # vimscript = ''
  #   highlight TelescopeNormal guibg=#1b1f27
  #   highlight TelescopeBorder guibg=#1b1f27 guifg=#1b1f27
  #   highlight TelescopePromptBorder guibg=#242930 guifg=#242930
  #   highlight TelescopePromptNormal guibg=#242930
  #   highlight TelescopePromptTitle guibg=#242930 guifg=#FFFFFF
  # '';

}
