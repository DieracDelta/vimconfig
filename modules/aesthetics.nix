{ pkgs, dsl, ... }:
with dsl; {
  plugins = with pkgs; [
    dracula
    vimPlugins.lualine-nvim
    vimPlugins.tabline-nvim
    vimPlugins.nvim-web-devicons
  ];

  vimscript = ''
    colorscheme dracula
  '';
  setup.tabline.show_index = false;

  setup.lualine = {
    options = {
      component_separators = {
        left = "";
        right = "";
      };
      section_separators = {
        left = "";
        right = "";
      };
      globalstatus = true;
    };
    sections = {
      lualine_a = [ "mode" ];
      lualine_b = [ "branch" "diff" "diagnostics" ];
      lualine_c = [ "filename" ];
      lualine_x = [ "encoding" "fileformat" ];
      lualine_z = [ "location" ];
    };
    tabline = { };
    extensions = { };
  };
}
