{ pkgs, dsl, ... }:
with dsl; {
  plugins = with pkgs; [
    conjure
  ];

  lua = ''
     vim.g['conjure#extract#tree_sitter#enabled'] = true
     vim.g['conjure#client#rust#evcxr#command'] = "${pkgs.evcxr}/bin/evcxr"
     vim.g['conjure#mapping#doc_word'] = nil
     vim.g['conjure#mapping#doc_str'] = nil
  '';

}
