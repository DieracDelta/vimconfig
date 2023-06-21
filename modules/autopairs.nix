{ pkgs, dsl, ... }:
with dsl; {
  plugins = with pkgs; [
    nvim-autopairs
  ];

  use.nvim-autopairs.setup = callWith {};


}
