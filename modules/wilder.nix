{ pkgs, dsl, ... }:
with dsl; {
  plugins = with pkgs; [
    wilder-nvim
    vimPlugins.cpsm
  ];

  lua = ''
    local wilder = require('wilder')
    wilder.setup({modes = {':', '/', '?'}})

    -- brocken rtp path
    -- https://github.com/gelguy/wilder.nvim/issues/109
    wilder.set_option("use_python_remote_plugin", 0)

    wilder.set_option('pipeline', {
      wilder.branch(
        wilder.python_file_finder_pipeline({
          file_command = function(ctx, arg)
            if string.find(arg, '.') ~= nil then
              return {'${pkgs.fd}/bin/fd', '-tf', '-H'}
            else
              return {'${pkgs.fd}/bin/fd', '-tf'}
            end
          end,
          dir_command = {'${pkgs.fd}/bin/fd', '-td'},
          filters = {'cpsm_filter'},
        }),
        wilder.substitute_pipeline({
          pipeline = wilder.python_search_pipeline({
            skip_cmdtype_check = 1,
          }),
        }),
        wilder.cmdline_pipeline({
          fuzzy = 2,
        }),
        {
          wilder.check(function(ctx, x) return x == "" end),
          wilder.history(),
        }
      ),
    })

    local highlighters = {
      wilder.pcre2_highlighter(),
      wilder.basic_highlighter(),
    }

    local popupmenu_renderer = wilder.popupmenu_renderer(
      wilder.popupmenu_palette_theme({
        border = 'rounded',
        empty_message = wilder.popupmenu_empty_message_with_spinner(),
        highlighter = highlighters,
        left = {
          ' ',
          wilder.popupmenu_devicons(),
          wilder.popupmenu_buffer_flags({
            flags = ' a + ',
            icons = {['+'] = '', a = '', h = ''},
          }),
        },
        right = {
          ' ',
          wilder.popupmenu_scrollbar(),
        },
      })
    )

    local wildmenu_renderer = wilder.wildmenu_renderer({
      highlighter = highlighters,
      separator = ' · ',
      left = {' ', wilder.wildmenu_spinner(), ' '},
      right = {' ', wilder.wildmenu_index()},
    })

    wilder.set_option('renderer', wilder.renderer_mux({
      [':'] = popupmenu_renderer,
      ['/'] = wildmenu_renderer,
      substitute = wildmenu_renderer,
    }))

  '';

}
