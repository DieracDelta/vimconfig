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

local function apply_ironmain_semantic_token_highlights()
  local filetypes = { "cobol", "jcl", "hlasm", "pli" }
  local semantic_palettes = {
    default = {
      namespace = "#fabd2f",
      type = "#fabd2f",
      parameter = "#8ec07c",
      variable = "#83a598",
      property = "#83a598",
      enumMember = "#d3869b",
      event = "#83a598",
      ["function"] = "#8ec07c",
      method = "#8ec07c",
      macro = "#d3869b",
      keyword = "#fe8019",
      modifier = "#fe8019",
      comment = "#928374",
      string = "#b8bb26",
      number = "#d3869b",
      regexp = "#b8bb26",
      operator = "#fe8019",
      decorator = "#d3869b",
    },
    darwin = {
      namespace = palettes.darwin.bright_yellow,
      type = palettes.darwin.bright_yellow,
      parameter = palettes.darwin.bright_green,
      variable = palettes.darwin.bright_blue,
      property = palettes.darwin.bright_blue,
      enumMember = palettes.darwin.bright_purple,
      event = palettes.darwin.bright_blue,
      ["function"] = palettes.darwin.bright_aqua,
      method = palettes.darwin.bright_aqua,
      macro = palettes.darwin.bright_purple,
      keyword = palettes.darwin.bright_orange,
      modifier = palettes.darwin.bright_orange,
      comment = palettes.darwin.gray,
      string = palettes.darwin.bright_green,
      number = palettes.darwin.bright_purple,
      regexp = palettes.darwin.bright_green,
      operator = palettes.darwin.bright_orange,
      decorator = palettes.darwin.bright_purple,
    },
    arm = {
      namespace = palettes.arm.bright_yellow,
      type = palettes.arm.bright_yellow,
      parameter = palettes.arm.bright_green,
      variable = palettes.arm.bright_blue,
      property = palettes.arm.bright_blue,
      enumMember = palettes.arm.bright_purple,
      event = palettes.arm.bright_blue,
      ["function"] = palettes.arm.bright_aqua,
      method = palettes.arm.bright_aqua,
      macro = palettes.arm.bright_purple,
      keyword = palettes.arm.bright_orange,
      modifier = palettes.arm.bright_orange,
      comment = palettes.arm.gray,
      string = palettes.arm.bright_green,
      number = palettes.arm.bright_purple,
      regexp = palettes.arm.bright_green,
      operator = palettes.arm.bright_orange,
      decorator = palettes.arm.bright_purple,
    },
  }
  local colors = semantic_palettes[theme_variant] or semantic_palettes.default

  local specs = {
    namespace = { fg = colors.namespace, bold = true },
    type = { fg = colors.type, bold = true },
    class = { fg = colors.type, bold = true },
    enum = { fg = colors.type, bold = true },
    interface = { fg = colors.type, bold = true },
    struct = { fg = colors.type, bold = true },
    typeParameter = { fg = colors.type, italic = true },
    parameter = { fg = colors.parameter, italic = true },
    variable = { fg = colors.variable },
    property = { fg = colors.property },
    enumMember = { fg = colors.enumMember, bold = true },
    event = { fg = colors.event },
    ["function"] = { fg = colors["function"], bold = true },
    method = { fg = colors.method, bold = true },
    macro = { fg = colors.macro, bold = true },
    keyword = { fg = colors.keyword, bold = true },
    modifier = { fg = colors.modifier, bold = true },
    comment = { fg = colors.comment, italic = true },
    string = { fg = colors.string },
    number = { fg = colors.number, bold = true },
    regexp = { fg = colors.regexp, italic = true },
    operator = { fg = colors.operator, bold = true },
    decorator = { fg = colors.decorator, bold = true },
  }

  for _, filetype in ipairs(filetypes) do
    for token_type, spec in pairs(specs) do
      vim.api.nvim_set_hl(0, "@lsp.type." .. token_type .. "." .. filetype, spec)
    end

    vim.api.nvim_set_hl(0, "@lsp.typemod.variable.definition." .. filetype, {
      fg = colors.variable,
      bold = true,
      underline = true,
    })
    vim.api.nvim_set_hl(0, "@lsp.typemod.parameter.definition." .. filetype, {
      fg = colors.parameter,
      bold = true,
      underline = true,
    })
    vim.api.nvim_set_hl(0, "@lsp.typemod.property.definition." .. filetype, {
      fg = colors.property,
      bold = true,
      underline = true,
    })
    vim.api.nvim_set_hl(0, "@lsp.typemod.function.definition." .. filetype, {
      fg = colors["function"],
      bold = true,
      underline = true,
    })
    vim.api.nvim_set_hl(0, "@lsp.typemod.method.definition." .. filetype, {
      fg = colors.method,
      bold = true,
      underline = true,
    })
    vim.api.nvim_set_hl(0, "@lsp.typemod.macro.definition." .. filetype, {
      fg = colors.macro,
      bold = true,
      underline = true,
    })
    vim.api.nvim_set_hl(0, "@lsp.typemod.variable.readonly." .. filetype, {
      fg = colors.variable,
      italic = true,
    })
    vim.api.nvim_set_hl(0, "@lsp.typemod.parameter.readonly." .. filetype, {
      fg = colors.parameter,
      italic = true,
    })
    vim.api.nvim_set_hl(0, "@lsp.typemod.property.readonly." .. filetype, {
      fg = colors.property,
      italic = true,
    })
  end
end

apply_ironmain_semantic_token_highlights()

vim.api.nvim_create_autocmd("ColorScheme", {
  callback = apply_ironmain_semantic_token_highlights,
})

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
