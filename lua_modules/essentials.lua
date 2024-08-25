vim.g.rustfmt_autosave = true
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
vim.api.nvim_set_keymap('n', '<leader>bn', '<cmd>bnext<cr>', {})
vim.api.nvim_set_keymap('n', '<leader>bp', '<cmd>bprev<cr>', {})
vim.api.nvim_set_keymap('n', '<leader>bN', '<cmd>tabedit<cr>', {})
vim.api.nvim_set_keymap('n', '<leader>bD', '<cmd>Bclose!<cr>', {})
vim.api.nvim_set_keymap('n', '<leader>wd', '<cmd>q<cr>', {})
vim.api.nvim_set_keymap('n', '<leader>wl', '<cmd>wincmd l<cr>', {})
vim.api.nvim_set_keymap('n', '<leader>wj', '<cmd>wincmd j<cr>', {})
vim.api.nvim_set_keymap('n', '<leader>wk', '<cmd>wincmd k<cr>', {})
vim.api.nvim_set_keymap('n', '<leader>wh', '<cmd>wincmd h<cr>', {})

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


