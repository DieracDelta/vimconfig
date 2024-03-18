{ pkgs, dsl, ... }:
with dsl; {
  plugins = with pkgs; [
    molten-nvim
  ];
}
