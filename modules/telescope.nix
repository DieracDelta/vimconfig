{ pkgs, dsl, ... }:
with dsl; {
  plugins = with pkgs; [
    # fuzzy finder
    telescope-nvim
    vimPlugins.telescope-file-browser-nvim
    # sexy dropdown
    telescope-ui-select
  ];

  lua = ''
    require("telescope").setup {
      defaults = {
        file_ignore_patterns = { "node_modules", "target" },
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
  '';
}
