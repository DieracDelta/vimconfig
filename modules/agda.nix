{ pkgs, dsl, ... }:
with dsl; {
  plugins = with pkgs; [
    vimPlugins.vim-textobj-user
    cornelis-vim
  ];

  vim.g.cornelis_use_global_binary = 1;

  vimscript = ''
    au BufRead,BufNewFile *.agda call AgdaFiletype()
    au BufWritePost *.agda execute "normal! :CornelisLoad\<CR>"
    function! CornelisLoadWrapper()
      if exists(":CornelisLoad") ==# 2
        CornelisLoad
      endif
    endfunction

    au BufReadPre *.agda call CornelisLoadWrapper()
    au BufReadPre *.lagda* call CornelisLoadWrapper()
  '';

}
