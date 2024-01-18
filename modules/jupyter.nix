{ pkgs, dsl, ... }:
with dsl; {
  plugins = with pkgs; [
    magma-nvim
  ];
}
