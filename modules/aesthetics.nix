{ pkgs, dsl, ... }:
with dsl; {
  plugins = with pkgs; [
    # dracula
    gruvbox-nvim
    vimPlugins.lualine-nvim
    vimPlugins.tabline-nvim
    vimPlugins.nvim-web-devicons
    node-type-nvim
    vim-circom-syntax
    # statusline-action-hints

    # jump to character on line
    # quick-scope
  ];

  # autocmd ColorScheme * highlight QuickScopePrimary guifg='#ff0000' guibg='#0000ff' ctermfg='196'
  # autocmd ColorScheme * highlight QuickScopeSecondary guifg='#880000' guibg='#000088' gui=underline ctermfg='196'
  vimscript = ''
    set background=dark
    colorscheme gruvbox
  '';
     # autocmd ColorScheme * highlight Comment guifg='#ff0000'

  setup.tabline.show_index = false;

  setup.node-type = {};
  # setup.statusline-action-hints = {
  #     definition_identifier = "gd";
  #     template = "%s ref:%s";
  # };

  lua = ''

 require("gruvbox").setup({
      terminal_colors = true, -- add neovim terminal colors
      undercurl = true,
      underline = true,
      bold = true,
      italic = {
        strings = true,
        emphasis = true,
        comments = true,
        operators = false,
        folds = true,
      },
      strikethrough = true,
      invert_selection = false,
      invert_signs = false,
      invert_tabline = false,
      invert_intend_guides = false,
      inverse = true, -- invert background for search, diffs, statuslines and errors
      contrast = "",  -- can be "hard", "soft" or empty string
      palette_overrides = {},
      overrides = {
        SignColumn = { link = "Normal" },
        GruvboxGreenSign = { bg = "" },
        GruvboxOrangeSign = { bg = "" },
        GruvboxPurpleSign = { bg = "" },
        GruvboxYellowSign = { bg = "" },
        GruvboxRedSign = { bg = "" },
        GruvboxBlueSign = { bg = "" },
        GruvboxAquaSign = { bg = "" },
        TelescopeSelection = { link = "Visual" },
        ["@variable"] = { link = "GruvboxBlue" },
        TermCursor = { bg = "#fabd2f", fg = "#282828" },
        Visual = {bg = "#d79921", fg = "#282828"},
        Linenr = {fg = "#7c6f64", bg = ""},
        debugPC = {fg = "", bg = "#3d4220"},
        DapBreakpoint = {fg = "", bg = "#472322"},
        DapBreakpointSymbol = {bg = ""}
      },
      dim_inactive = false,
      transparent_mode = false,
    })

  '';
  setup.lualine = {
    options = {
      component_separators = {
        left = "";
        right = "";
      };
      section_separators = {
        left = "";
        right = "";
      };
      globalstatus = true;
    };
    sections = {
      lualine_a = [ "mode" ];
      lualine_b = [ "branch" "diff" "diagnostics" ];
      lualine_c = [ "filename" ];
      # lualine_x = [/* (rawLua "require(\"statusline-action-hints\").statusline") */ (rawLua "require(\"node-type\").statusline") "encoding" "fileformat" ];
      lualine_z = [ "location" ];
    };
    tabline = { };
    extensions = { };
  };
}
