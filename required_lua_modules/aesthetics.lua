-- gruvbox with host-specific theming
-- Theme variant is set by Nix at build time: darwin (green), arm (red), or default (gruvbox)
local theme_variant = vim.g.gruvbox_theme_variant or "default"

-- Host-specific palette overrides matching tmux themes exactly
-- Colors sourced from /home/jrestivo/dev/tmux-gruvbox-themes/src/palette_*.sh
local palettes = {
  darwin = {
    -- Forest green theme (exact match to tmux darwin palette)
    -- Backgrounds
    dark0_hard = "#141c18",
    dark0 = "#1a2420",
    dark0_soft = "#1e2c28",
    dark1 = "#243330",
    dark2 = "#2e4240",
    dark3 = "#3a524f",
    dark4 = "#476260",
    -- Foregrounds
    light0_hard = "#e8f5e4",
    light0 = "#d4e5d0",
    light0_soft = "#d4e5d0",
    light1 = "#d4e5d0",
    light2 = "#b8ccb4",
    light3 = "#9cb398",
    light4 = "#809a7c",
    -- Bright accents (col_*2 from tmux)
    bright_red = "#c47e7e",
    bright_green = "#7ec47e",
    bright_yellow = "#c4c47e",
    bright_blue = "#7ea0c4",
    bright_purple = "#a07ec4",
    bright_aqua = "#7ec4c4",
    bright_orange = "#c4a07e",
    -- Neutral accents (col_* from tmux)
    neutral_red = "#9e5f5f",
    neutral_green = "#5f9e5f",
    neutral_yellow = "#9e9e5f",
    neutral_blue = "#5f7e9e",
    neutral_purple = "#7e5f9e",
    neutral_aqua = "#5f9e9e",
    neutral_orange = "#9e7e5f",
    -- Faded accents
    faded_red = "#7a4a4a",
    faded_green = "#4a7a4a",
    faded_yellow = "#7a7a4a",
    faded_blue = "#4a607a",
    faded_purple = "#604a7a",
    faded_aqua = "#4a7a7a",
    faded_orange = "#7a604a",
    -- Diff backgrounds (green-tinted)
    dark_red_hard = "#3a2828",
    dark_red = "#3d2a2a",
    dark_red_soft = "#402c2c",
    dark_green_hard = "#2a3a28",
    dark_green = "#2d3d2a",
    dark_green_soft = "#304030",
    dark_aqua_hard = "#283a34",
    dark_aqua = "#2a3d36",
    dark_aqua_soft = "#2c403a",
    -- Gray (from col_gray0)
    gray = "#809a7c",
  },
  arm = {
    -- Crimson red theme (exact match to tmux nixos-arm palette)
    -- Backgrounds
    dark0_hard = "#1c1414",
    dark0 = "#241a1a",
    dark0_soft = "#2c1e1e",
    dark1 = "#332424",
    dark2 = "#422e2e",
    dark3 = "#523a3a",
    dark4 = "#624747",
    -- Foregrounds
    light0_hard = "#f5e8e4",
    light0 = "#e5d4d0",
    light0_soft = "#e5d4d0",
    light1 = "#e5d4d0",
    light2 = "#ccb8b4",
    light3 = "#b39c98",
    light4 = "#9a807c",
    -- Bright accents (col_*2 from tmux)
    bright_red = "#c47070",
    bright_green = "#7ea07e",
    bright_yellow = "#c4a07e",
    bright_blue = "#7e90c4",
    bright_purple = "#a07ea0",
    bright_aqua = "#7ea0a0",
    bright_orange = "#c48060",
    -- Neutral accents (col_* from tmux)
    neutral_red = "#9e4f4f",
    neutral_green = "#5f7e5f",
    neutral_yellow = "#9e7e5f",
    neutral_blue = "#5f6e9e",
    neutral_purple = "#7e5f7e",
    neutral_aqua = "#5f7e7e",
    neutral_orange = "#9e6040",
    -- Faded accents
    faded_red = "#7a3a3a",
    faded_green = "#4a5f4a",
    faded_yellow = "#7a604a",
    faded_blue = "#4a507a",
    faded_purple = "#5f4a5f",
    faded_aqua = "#4a5f5f",
    faded_orange = "#7a4a30",
    -- Diff backgrounds (red-tinted)
    dark_red_hard = "#3a2020",
    dark_red = "#3d2222",
    dark_red_soft = "#402424",
    dark_green_hard = "#2a3028",
    dark_green = "#2d3330",
    dark_green_soft = "#303632",
    dark_aqua_hard = "#283030",
    dark_aqua = "#2a3333",
    dark_aqua_soft = "#2c3636",
    -- Gray (from col_gray0)
    gray = "#9a807c",
  },
  default = {}, -- Use original gruvbox colors
}

-- Theme-specific highlight overrides
local cursor_colors = {
  darwin = { bg = "#7ec47e", fg = "#1a2420" },
  arm = { bg = "#c47070", fg = "#241a1a" },
  default = { bg = "#fabd2f", fg = "#282828" },
}

local visual_colors = {
  darwin = { bg = "#5f9e5f", fg = "#1a2420" },
  arm = { bg = "#9e4f4f", fg = "#241a1a" },
  default = { bg = "#d79921", fg = "#282828" },
}

local linenr_colors = {
  darwin = { fg = "#6b7b70", bg = "" },
  arm = { fg = "#7b6b6b", bg = "" },
  default = { fg = "#7c6f64", bg = "" },
}

require("gruvbox").setup({
  terminal_colors = true,
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
  inverse = true,
  contrast = "",
  palette_overrides = palettes[theme_variant] or {},
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
    TermCursor = cursor_colors[theme_variant] or cursor_colors.default,
    Visual = visual_colors[theme_variant] or visual_colors.default,
    Linenr = linenr_colors[theme_variant] or linenr_colors.default,
    debugPC = { fg = "", bg = "#3d4220" },
    DapBreakpoint = { fg = "", bg = "#472322" },
    DapBreakpointSymbol = { bg = "" },
  },
  dim_inactive = false,
  transparent_mode = false,
})
vim.o.background = "dark"
vim.cmd("colorscheme gruvbox")
-- lualine
require("lualine").setup({
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
    lualine_a = { "mode" },
    lualine_b = { "branch", "diff", "diagnostics" },
    lualine_c = { "filename" },
    lualine_z = { "location" },
  },
})
