-- gruvbox
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
vim.o.background = "dark"
vim.cmd("colorscheme gruvbox")
-- lualine
require('lualine').setup(
  {
    option = {
      component_separators = {
        left = "",
        right = "",
      },
      sections_separators = {
        left = "",
        right = "",
      },
      globalstatus = true,
    },
    sections = {
      lualine_a = {'mode'},
      lualine_b = {'branch', 'diff', 'diagnostics'},
      lualine_c = {'filename'},
      lualine_z = {'location'},
    },
  }
)
