{ pkgs, dsl, ... }:
with dsl; {
  plugins = with pkgs; [
    # for showing ansi escape sequences
    colorizer
    # for generating boilerplate for comments
    neogen
    # sick parinfer mode fast asf
    parinfer-rust-nvim
  ];
  use.neogen.setup = callWith { enabled = true; };
}
