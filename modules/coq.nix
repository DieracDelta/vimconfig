{ pkgs, dsl, ...}:
with dsl;
{

  # use.lspconfig."bsl_ls".setup =
  #   callWith {
  #     cmd = [ "${pkgs.coq-lsp}/bin/coq-lsp" ];
  #     filetypes = [ "coq" "verilog" ];
  #   };

  plugins = with pkgs; [
    vscoq-nvim
    coq-lsp-nvim
    vimPlugins.Coqtail
  ];

  vimscript = ''
    let g:loaded_coqtail = 1
    let g:coqtail#supported = 0
  '';

  # use.lspconfig.vscoq.setup =
  #   callWith { cmd = [ "${pkgs.vscoqlsp}/bin/vscoqtop" ]; };

    # require'coq-lsp'.setup{
    # }
  lua = ''
    require'vscoq'.setup({ lsp = { cmd = {"${pkgs.vscoqlsp}/bin/vscoqtop"}}})

  '';
}
