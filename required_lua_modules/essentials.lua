vim.loader.enable(true)
vim.g.rustfmt_autosave = false
vim.g.diagnostics_visible = true
vim.g.inlay_hints_visible = true
-- perl bad
vim.g.loaded_perl_provider = 0
vim.g.mapleader = " "
vim.g.maplocalleader = ","
vim.g.nofoldenable = true
vim.g.noshowmode = true
vim.g.completeopt = "menu,menuone,noselect"
vim.g.noswapfile = true

vim.o.tabstop = 2
vim.o.shiftwidth = 2
vim.o.softtabstop = 2
vim.o.showcmd = true
vim.o.showmatch = true
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.cursorline = true
vim.o.cursorcolumn = true
vim.o.wrap = true
vim.o.autoindent = true
vim.o.copyindent = true
vim.o.splitbelow = true
vim.o.splitright = true
vim.o.number = true
vim.o.relativenumber = true
vim.o.title = true
vim.o.undofile = true
vim.o.autoread = true
vim.o.hidden = true
vim.o.list = true
vim.o.background = "dark"
vim.o.backspace = "indent,eol,start"
vim.o.undolevels = 1000000
vim.o.undoreload = 1000000
vim.o.foldmethod = "indent"
vim.o.foldnestmax = 10
vim.o.scrolloff = 3
vim.o.sidescrolloff = 5
vim.o.listchars = "tab:→→,trail:●,nbsp:○"
vim.o.formatoptions = "tcqj"
vim.o.encoding = "utf-8"
vim.o.fileencoding = "utf-8"
vim.o.fileencodings = "utf-8"
vim.o.bomb = true
vim.o.binary = true
vim.o.matchpairs = "(:),{:},[:],<:>"
vim.o.expandtab = true
vim.o.wildmode = "list:longest,list:full"
-- for nvim-ufo
vim.o.foldcolumn = "1"
vim.o.foldlevel = 99
vim.o.foldlevelstart = 99
vim.o.foldenable = true

vim.api.nvim_set_keymap('n', 'j', 'gj', {}) -- wrapped down
vim.api.nvim_set_keymap('n', 'k', 'gk', {}) -- wrapped up

vim.api.nvim_set_keymap('n', '<leader>ws', '<cmd>sp<cr>', {})
vim.api.nvim_set_keymap('n', '<leader>wv', '<cmd>vs<cr>', {})
vim.api.nvim_set_keymap('n', '<leader>bd', '<cmd>q<cr>', {})
-- vim.api.nvim_set_keymap('n', '<leader>bn', '<cmd>bnext<cr>', {})
-- vim.api.nvim_set_keymap('n', '<leader>bp', '<cmd>bprev<cr>', {})
vim.api.nvim_set_keymap('n', '<leader>bN', '<cmd>tabedit<cr>', {})
vim.api.nvim_set_keymap('n', '<leader>bD', '<cmd>Bclose!<cr>', {})
vim.api.nvim_set_keymap('n', '<leader>wd', '<cmd>q<cr>', {})
vim.api.nvim_set_keymap('n', '<leader>wl', '<cmd>wincmd l<cr>', {})
vim.api.nvim_set_keymap('n', '<leader>wj', '<cmd>wincmd j<cr>', {})
vim.api.nvim_set_keymap('n', '<leader>wk', '<cmd>wincmd k<cr>', {})
vim.api.nvim_set_keymap('n', '<leader>wh', '<cmd>wincmd h<cr>', {})
vim.api.nvim_set_keymap('n', '<leader>wL', '<cmd>wincmd x<cr>', {})
vim.api.nvim_set_keymap('n', '<leader>wJ', '<cmd>wincmd J<cr>', {})
vim.api.nvim_set_keymap('n', '<leader>wK', '<cmd>wincmd K<cr>', {})
vim.api.nvim_set_keymap('n', '<leader>wH', '<cmd>wincmd H<cr>', {})

vim.api.nvim_set_keymap('n', 'k', 'gk', {}) -- show docs. TODO move to lsp file

-- Flag to check if clipboard has been set
local clipboard_set = false

-- Autocmd to set clipboard to use the system clipboard on first file open
vim.api.nvim_create_autocmd("BufRead", {
  callback = function()
    if not clipboard_set then
      vim.opt.clipboard:append("unnamedplus")
      clipboard_set = true
    end
  end
})

vim.g.clipboard = {
  name = 'OSC 52',
  copy = {
    ['+'] = require('vim.ui.clipboard.osc52').copy('+'),
    ['*'] = require('vim.ui.clipboard.osc52').copy('*'),
  },
  paste = {
    ['+'] = require('vim.ui.clipboard.osc52').paste('+'),
    ['*'] = require('vim.ui.clipboard.osc52').paste('*'),
  },
}

-- Function to clean trailing spaces on save
local function clean_extra_spaces()
    local save_cursor = vim.fn.getpos(".")
    local old_query = vim.fn.getreg("/")
    vim.cmd([[%s/\s\+$//e]])
    vim.fn.setpos('.', save_cursor)
    vim.fn.setreg('/', old_query)
end

-- Autocommand to call clean_extra_spaces function before saving
vim.api.nvim_create_autocmd("BufWritePre", {
    pattern = "*",
    callback = clean_extra_spaces,
})

-- Preserve cursor location after opening a file
vim.api.nvim_create_autocmd("BufReadPost", {
    pattern = "*",
    callback = function()
        local line = vim.fn.line
        if line("'\"") >= 1 and line("'\"") <= line("$") then
            vim.cmd([[normal! g`"]])
        end
    end,
})


vim.api.nvim_set_keymap('n', '<leader>fy', [[:let @+ = expand('%:p')<CR>]], { noremap = true, silent = true })

function filtered_bufnav(direction)
  -- Get all listed buffers as a table of info.
  local bufs = vim.fn.getbufinfo({ buflisted = 1 })
  local cur = vim.api.nvim_get_current_buf()
  local start_index = nil

  -- Find the index of the current buffer.
  for i, buf in ipairs(bufs) do
    if buf.bufnr == cur then
      start_index = i
      break
    end
  end

  if not start_index then
    print("Current buffer not found!")
    return
  end

  local count = #bufs
  local target_buf = nil

  for i = 1, count do
    local idx
    if direction == 1 then
      idx = ((start_index + i - 1) % count) + 1
    elseif direction == -1 then
      -- Lua modulo always returns a non-negative result.
      idx = ((start_index - i - 1) % count) + 1
    else
      error("Invalid direction: " .. tostring(direction))
    end

    local buf = bufs[idx]
    -- Filter out Coq panel buffers (assumes their name starts with "CoqInfoPanel:")
    if not buf.name:match("CoqInfoPanel") then
      target_buf = buf.bufnr
      break
    end
  end

  if target_buf then
    vim.cmd("buffer " .. target_buf)
  else
    print("No non-Coq buffer found")
  end
end

-- Map for bnext (direction = 1)
vim.api.nvim_set_keymap(
  'n',
  '<leader>bn',
  '<cmd>lua filtered_bufnav(1)<cr>',
  { noremap = true, silent = true }
)

-- Map for bprev (direction = -1)
vim.api.nvim_set_keymap(
  'n',
  '<leader>bp',
  '<cmd>lua filtered_bufnav(-1)<cr>',
  { noremap = true, silent = true }
)

vim.api.nvim_create_autocmd({ "BufReadPost", "FileType" }, {
  callback = function()
    vim.treesitter.stop()  -- immediately halt any parser startup
  end,
})
