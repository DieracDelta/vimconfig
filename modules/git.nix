{ pkgs, dsl, ... }:
with dsl; {
  plugins = with pkgs; [ vimPlugins.neogit blamer-nvim ];
  use.neogit.setup = callWith { };
}
