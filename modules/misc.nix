{ pkgs, dsl, ... }:
with dsl; {
  plugins = with pkgs; [
    # for showing ansi escape sequences
    colorizer
    # for generating boilerplate for comments
    neogen
    # sick parinfer mode fast asf
    parinfer-rust-nvim
    # surroundings stuffs
    vimPlugins.surround-nvim
    # undo tree
    vimPlugins.undotree
  ];

  setup.neogen.enabled = true;

  use.surround.setup = callWith {
    context_offset = 100;
    load_autogroups = false;
    mappings_style = "sandwich";
    map_insert_mode = true;
    quotes = ["'" "\""];
    brackets = ["(" "{" "["];
    space_on_closing_char = false;
    pairs = {
      nestable = {
        b = [ "(" ")" ];
        s = [ "[" "]" ];
        B = [ "{" "}" ];
        a = [ "<" ">" ];
      };
      linear = {
        q = [ "'" "'" ];
        t = [ "`" "`" ];
        d = [ "\"" "\"" ];
      };
    };
    prefix = "s";
  };

}
