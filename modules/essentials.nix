{ pkgs, dsl, ... }:
with dsl; {
  plugins = with pkgs; [
    # command discover
    which-key
    # for sane tab detection
    vimPlugins.vim-sleuth
  ];

  set.autoread = true;

  vim.g = {
    mapleader = " ";
    nofoldenable = true;
    noshowmode = true;
    completeopt = "menu,menuone,noselect";
    noswapfile = true;
    blamer_enabled = 1;
  };

  vim.o = {
    showcmd = true;
    showmatch = true;
    ignorecase = true;
    smartcase = true;
    cursorline = true;
    wrap = true;
    autoindent = true;
    copyindent = true;
    splitbelow = true;
    splitright = true;
    number = true;
    relativenumber = true;
    title = true;
    undofile = true;
    autoread = true;
    hidden = true;
    list = true;
    background = "dark";
    backspace = "indent,eol,start";
    undolevels = 1000000;
    undoreload = 1000000;
    foldmethod = "indent";
    foldnestmax = 10;
    foldlevel = 1;
    scrolloff = 3;
    sidescrolloff = 5;
    listchars = "tab:→→,trail:●,nbsp:○";
    clipboard = "unnamed,unnamedplus";
    formatoptions = "tcqj";
    encoding = "utf-8";
    fileencoding = "utf-8";
    fileencodings = "utf-8";
    bomb = true;
    binary = true;
    matchpairs = "(:),{:},[:],<:>";
    expandtab = true;
    #pastetoggle = "<leader>v";
    wildmode = "list:longest,list:full";
  };

  use.which-key.register = dsl.callWith {
    "K" = [ "<cmd>lua show_documentation()<CR>" "Get Type Information" ];
    "j" = [ "gj" "Wrapped down" ];
    "k" = [ "gk" "Wrapped up" ];
    "['<leader>']" = {
      name = "+leader_bindings";
      "ai" = [ "<cmd>AnsiEsc<CR>" "Replace ansi escape codes with colors" ];
      "D" = [ "<cmd>lua vim.lsp.buf.declaration()<CR>" "Jump to Declaration" ];
      "d" = [ "<cmd>lua vim.lsp.buf.definition()<CR>" "Jump to Definition" ];
      "i" = [
        "<cmd>lua vim.lsp.buf.implementation()<CR>"
        "Jump to Implementation"
      ];
      "s" = [
        "<cmd>lua vim.lsp.buf.signature_help()<CR>"
        "Get function signature"
      ];
      "k" =
        [ "<cmd>lua vim.lsp.buf.type_definition()<CR>" "Get type definition" ];
      "rn" = [ "<cmd>lua vim.lsp.buf.rename()<CR>" "Rename function/variable" ];
      "ca" = [ "<cmd>lua vim.lsp.buf.code_action()<CR>" "Perform code action" ];
      "r" = [
        "<cmd>lua vim.lsp.buf.references()<CR>"
        "Get function/variable refs"
      ];
      "e" = [
        "<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>"
        "Get lsp errors"
      ];
      "f" = [ "<cmd>lua vim.lsp.buf.formatting()<CR>" "Format buffer" ];
      "bb" = [ "<cmd>Telescope buffers<cr>" "Get buffer list" ];
      "fb" = [ "<cmd>Telescope file_browser<cr>" "Get buffer list" ];
      "gg" = [ "<cmd>Telescope live_grep<cr>" "Fzf fuzzy search" ];
      "['<leader>']" = [ "<cmd>Telescope find_files<cr>" "search files" ];
      "ws" = [ "<cmd>sp<cr>" "Split window horizontally" ];
      "wv" = [ "<cmd>vs<cr>" "Split window vertically" ];
      "bd" = [ "<cmd>q<cr>" "Delete buffer" ];
      "bn" = [ "<cmd>bnext<cr>" "Next buffer" ];
      "bp" = [ "<cmd>bprev<cr>" "Previous buffer" ];
      "bN" = [ "<cmd>tabedit<cr>" "New buffer/tab" ];
      "bD" = [ "<cmd>Bclose!<cr>" "Delete buffer aggressively" ];
      "wd" = [ "<cmd>q<cr>" "Delete window" ];
      "wl" = [ "<cmd>wincmd l<cr>" "Move window right" ];
      "wj" = [ "<cmd>wincmd j<cr>" "Move window down" ];
      "wk" = [ "<cmd>wincmd k<cr>" "Move window up" ];
      "wh" = [ "<cmd>wincmd h<cr>" "Move window left" ];
      "gs" =
        [ "<cmd>lua require('neogit').open()<CR>" "Open neogit (magit clone)" ];
      "gb" = [ "<cmd>BlamerToggle<CR>" "Toggle git blame" ];
      "gc" = [ "<cmd>Neogen<CR>" "generate comments boilerplate" ];

      "l" = [ "<cmd>Telescope resume<CR>" "last telescope query" ];

      "gf" = [
        "<cmd>lua require('telescope.builtins').live_grep {default_text='function'}<CR>"
        "grep for functions only"
      ];
      "hs" = [ "<cmd>Gitsigns preview_hunk<CR>" "preview hunk" ];
      "hn" = [ "<cmd>Gitsigns next_hunk<CR>" "next hunk" ];
      "hp" = [ "<cmd>Gitsigns prev_hunk<CR>" "prev hunk" ];

      "rm" = [
        "<cmd>lua require'rust-tools.expand_macro'.expand_macro()<CR>"
        "Expand macro"
      ];
      "rh" = [
        "cmd lua require('rust-tools.inlay_hints').toggle_inlay_hints()<CR>"
        "toggle inlay type hints"
      ];
      "rpm" = [
        "cmd lua require'rust-tools.parent_module'.parent_module()<CR>"
        "go to parent module"
      ];
      "rJ" = [
        "cmd lua require'rust-tools.join_lines'.join_lines()<CR>"
        "join lines rust"
      ];
      "cu" = [ "lua require('crates').update_crate()" "update a crate" ];
      "cua" =
        [ "lua require('crates').update_all_crates()" "update all crates" ];
      "cU" = [ "lua require('crates').upgrade_crate()" "upgrade a crate" ];
      "cUa" =
        [ "lua require('crates').upgrade_all_crates()" "upgrade all crates" ];

    };
  };
  use.which-key.setup = callWith { };

  # yoinked from gytis
  vimscript = ''
    " Function to clean trailing Spaces on save
    function! CleanExtraSpaces() "Function to clean unwanted spaces
        let save_cursor = getpos(".")
        let old_query = getreg('/')
        silent! %s/\s\+$//e
        call setpos('.', save_cursor)
        call setreg('/', old_query)
    endfun
    autocmd BufWritePre * :call CleanExtraSpaces()
    " Preserve cursor location
    autocmd BufReadPost *
      \ if line("'\"") >= 1 && line("'\"") <= line("$") |
      \   exe "normal! g`\"" |
      \ endif
  '';
}
