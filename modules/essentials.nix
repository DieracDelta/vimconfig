{ pkgs, dsl, ... }:
with dsl;
let
  cmd = command: desc: [ "<cmd>${command}<cr>" desc ];
in
{
  plugins = with pkgs; [
    # for getting github links
    nvim-github-linker
    # command discover
    which-key
    # for sane tab detection
    guess-indent
  ];

  set.autoread = true;

  vim.g = {
    # perl bad
    loaded_perl_provider = 0;
    mapleader = " ";
    maplocalleader = ",";
    nofoldenable = true;
    noshowmode = true;
    completeopt = "menu,menuone,noselect";
    noswapfile = true;
  };

  vim.o = {
    showcmd = true;
    showmatch = true;
    ignorecase = true;
    smartcase = true;
    cursorline = true;
    cursorcolumn = true;
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
    # for nvim-ufo
    foldcolumn = "1";
    foldlevel = 99;
    foldlevelstart = 99;
    foldenable = true;

  };

  use.which-key.register = dsl.callWith {
    "K" = [ "<cmd>lua show_documentation()<CR>" "Get Type Information" ];
    "j" = [ "gj" "Wrapped down" ];
    "k" = [ "gk" "Wrapped up" ];
    "['<leader>']" = {
      name = "+leader_bindings";

      ai = cmd "AnsiEsc" "Replace ansi escape codes with colors";
      D = cmd "lua vim.lsp.buf.declaration()" "Jump to Declaration";
      d = cmd "lua vim.lsp.buf.definition()" "Jump to Definition";
      i = cmd "lua vim.lsp.buf.implementation()" "Jump to Implementation";
      s = cmd "lua vim.lsp.buf.signature_help()" "Get function signature";
      u = ["<cmd>UndotreeToggle<CR>" "Trigger UndoTree"];

      "yg" = [ "<cmd>lua (function() vim.api.nvim_command('redir @+') vim.api.nvim_exec('GithubLink', true) vim.api.nvim_command('redir END') local output = vim.fn.getreg('+') local modifiedOutput = output:gsub(\"^\n?git@\", \"\") if modifiedOutput == \"\" then print(\"No output from GithubLink command\") else vim.fn.setreg(\"+\", modifiedOutput) print(\"Output has been copied to the clipboard\") end end)() <CR>" "Link to github"];
      "k" = [ "<cmd>lua vim.lsp.buf.type_definition()<CR>" "Get type definition" ];
      "rn" = [ "<cmd>lua vim.lsp.buf.rename()<CR>" "Rename function/variable" ];
      "ca" = [ "<cmd>lua vim.lsp.buf.code_action()<CR>" "Perform code action" ];
      "r" = [
        "<cmd>lua vim.lsp.buf.references()<CR>"
        "Get function/variable refs"
      ];
      "e" = [
        "<cmd>lua vim.diagnostic.open_float()<CR>"
        "Get lsp errors"
      ];
      "dn" = [
        "<cmd>lua vim.diagnostic.goto_next()<CR>"
        "next diag"
      ];
      "dp" = [
        "<cmd>lua vim.diagnostic.goto_prev()<CR>"
        "prev diag"
      ];
      "mb" = [ ":VimtexCompile<CR>" "build latex buffer" ];
      "f" = [ "<cmd>lua vim.lsp.buf.formatting()<CR>" "Format buffer" ];
      "bb" = [ "<cmd>Telescope buffers<cr>" "Get buffer list" ];
      "fb" = [ "<cmd>Telescope file_browser<cr>" "Get buffer list" ];
      "gg" = [ "<cmd>Telescope live_grep<cr>" "Fzf fuzzy search" ];
      "['<leader>']" = [ "<cmd>Telescope find_files<cr>" "search files" ];
      "n"  = ["<cmd>lua require(\"sg.telescope\").fuzzy_search_results()<CR>" "sourcegraph search"];

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
      "gi" =
        [ "<cmd>GuessIndent<CR>" "guess indent again" ];


      # adga specific things
      "ad" = [ "<cmd>CornelisGoToDefinition<CR>" "Goto agda defn" ];
      "ar" = [ "<cmd>CornelisLoad<CR>" "Reload Agda buffer" ];
      "aR" = [ "<cmd>CornelisRefine<CR>" "Refine type" ];
      "agn" = [ "<cmd>CornelisNextGoal<CR>" "Goto next goal" ];
      "agp" = [ "<cmd>CornelisPrevGoal<CR>" "Goto prev goal" ];
      "as" = [ "<cmd>CornelisSolve<CR>" "Goto prev goal" ];
      "at" = [ "<cmd>CornelisAuto<CR>" "Auto whatever that means" ];
      "aK" = [ "<cmd>CornelisTypeContext<CR>" "Type context" ];
      "amc" = [ "<cmd>CornelisMakeCase<CR>" "Make case" ];

      # trouble keybinds
      "xx" = [ "<cmd>TroubleToggle<CR>" "Toggle trouble diagnostics" ] ;
      "xw" = [ "<cmd>TroubleToggle workspace_diagnostics<CR>" "Toggle trouble workspace diagnostics" ];
      "xd" = [ "<cmd>TroubleToggle document_diagnostics<CR>" "Toggle trouble document diagnostics" ];
      "xq" = [ "<cmd>TroubleToggle quickfix<CR>" "Toggle trouble quickfix list"];
      "xl" = [ "<cmd>TroubleToggle loclist<CR>" "Toggle trouble local list" ];
      "xr" = [ "<cmd>TroubleToggle lsp_references<CR>" "Toggle trouble lsp references" ];
      "xn" = [ "cmd lua require(\"trouble\").next({skip_groups = true, jump = true})<CR>" "Jump next diagnostic"];
      "xp" = [ "cmd lua require(\"trouble\").previous({skip_groups = true, jump = true})<CR>" "Jump next diagnostic"];

      # dap shit
      "pc" = [ "<Cmd>lua require'dap'.continue()<CR>" "Dap Continue" ];
      "po" = [ "<Cmd>lua require'dap'.step_over()<CR>" "Dap Step over" ];
      "pi" = [ "<Cmd>lua require'dap'.step_into()<CR>" "Dap Step into" ];
      "pO" = [ "<Cmd>lua require'dap'.step_out()<CR>" "Dap Step out" ];
      "pb" = [ "<Cmd>lua require'dap'.toggle_breakpoint()<CR>" "Dap Toggle breakpoint" ];
      "pr" = [ "<Cmd>lua require'dap'.repl.open()<CR>" "Dap Open repl" ];
      "pl" = [ "<Cmd>lua require'dap'.run_last()<CR>" "Dap Run last" ];
      "pu" = [ "<Cmd>lua require'dapui'.toggle()<CR>" "Dap UI Toggle" ];
      "pC" = [ "<Cmd>lua require'telescope'.extensions.dap.commands{}<CR>" "Dap commands" ];
      "pa" = [ "<Cmd>lua require'telescope'.extensions.dap.configurations{}<CR>" "Dap configurations" ];
      "pL" = [ "<Cmd>lua require'telescope'.extensions.dap.list_breakpoints{}<CR>" "Dap list breakpoints" ];
      "pv" = [ "<Cmd>lua require'telescope'.extensions.dap.variables{}<CR>" "Dap list variables" ];
      "pf" = [ "<Cmd>lua require'telescope'.extensions.dap.frames{}<CR>" "Dap list frames" ];
      "pe" = [ "<Cmd>lua require('dapui').eval(vim.fn.input('Expression to evaluate: '))<CR>" "Dap eval expression" ];
      "ps" = [ "<Cmd>lua require('dap.ext.vscode').load_launchjs(nil, { [\"lldb\"] = {\"rust\"} })<CR>" "Dap load configs" ];



      "na" = [ "<Cmd>lua require(\"ts-node-action\").node_action{}<CR>" "Trigger Node Action"];


      "tm" = [ "<Cmd>lua require(\"trailblazer\").new_trail_mark()<CR>" "Trailblazer: new trail mark"];
      "tb" = [ "<Cmd>lua require(\"trailblazer\").track_back()<CR>" "Trailblazer: track back (deletes mark)"];
      "tn" = [ "<Cmd>lua require(\"trailblazer\").peek_move_next_down()<CR>" "Trailblazer: next down"];
      "tp" = [ "<Cmd>lua require(\"trailblazer\").peek_move_previous_up()<CR>" "Trailblazer: previous up"];
      "tj" = [ "<Cmd>lua require(\"trailblazer\").move_to_nearest()<CR>" "Trailblazer: jump to nearest"];
      "tl" = [ "<Cmd>lua require(\"trailblazer\").toggle_trail_mark_list()<CR>" "Trailblazer: list"];
      "tD" = [ "<Cmd>lua require(\"trailblazer\").delete_all_trail_marks()<CR>" "Trailblazer: nuke all trail marks"];
      "tq" = [ "<Cmd>lua require(\"trailblazer\").paste_at_last_trail_mark()<CR>" "Trailblazer: paste at last trail mark"];
      "tQ" = [ "<Cmd>lua require(\"trailblazer\").paste_at_all_trail_marks()<CR>" "Trailblazer: paste at all trail marks"];
      "ts" = [ "<Cmd>lua require(\"trailblazer\").switch_to_next_trail_mark_stack()<CR>" "Trailblazer: next mark stack"];
      "tS" = [ "<Cmd>lua require(\"trailblazer\").switch_to_previous_trail_mark_stack()<CR>" "Trailblazer: previous mark stack"];
      "to" = [ "<Cmd>lua require(\"trailblazer\").set_trail_mark_stack_sort_mode()<CR>" "Trailblazer: sort mode"];
      "ti" = [ "<Cmd>lua require(\"trailblazer\").set_trail_mark_select_mode()<CR>" "Trailblazer: select mode"];
      "tz" = [ "<Cmd>TrailBlazerSaveSession<CR>" "Trailblazer: save"];
      "tZ" = [ "<Cmd>TrailBlazerLoadSession<CR>" "Trailblazer: load"];

    };
  };
  use.which-key.setup = callWith { };




  use.guess-indent.setup = callWith { };





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

    autocmd BufRead,BufNewFile *  highlight CursorLine guibg=#63511f
    autocmd BufRead,BufNewFile * highlight CursorColumn guibg=#63511f

  '';
}
