{ pkgs, dsl, ... }:
with dsl; {
  plugins = with pkgs; [
    vimPlugins.neogit
    blamer-nvim
    vimPlugins.diffview-nvim
    vimPlugins.gitsigns-nvim
  ];
  setup.gitsigns = { };
  setup.neogit = {
    signs = {
      section = [ "" "" ];
      item = [ "" "" ];
    };

    integrations.diffview = true;
  };
}
