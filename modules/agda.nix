{ pkgs, dsl, ... }:
with dsl; {
  plugins = with pkgs; [
    vimPlugins.vim-textobj-user
    cornelis-vim
  ];

  lua = ''
    vim.g.cornelis_use_global_binary = 1
  '';
}
