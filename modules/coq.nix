{ pkgs, dsl, ...}:
{

  # use.lspconfig."bsl_ls".setup =
  #   callWith {
  #     cmd = [ "${pkgs.coq-lsp}/bin/coq-lsp" ];
  #     filetypes = [ "coq" "verilog" ];
  #   };

  plugins = with pkgs; [
    coq-lsp-nvim
    vimPlugins.Coqtail
  ];

  vimscript = ''
    let g:loaded_coqtail = 1
    let g:coqtail#supported = 0
  '';

  lua = ''
    require'coq-lsp'.setup{
      lsp = {
        cmd = { "${pkgs.coq-lsp}/bin/coq-lsp" }
      }
    }
  '';
}
