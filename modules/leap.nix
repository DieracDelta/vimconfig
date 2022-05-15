{ pkgs, dsl, ... }:
with dsl; {
  plugins = with pkgs; [ vimPlugins.repeat leap ];

  lua = ''
    require('leap').setup {
      case_insensitive = true,
      -- Leaving the appropriate list empty effectively disables "smart" mode,
      -- and forces auto-jump to be on or off.
      -- These keys are captured directly by the plugin at runtime.
      special_keys = {
        repeat_search = '<enter>',
        next_match    = '<enter>',
        prev_match    = '<tab>',
        next_group    = '<space>',
        prev_group    = '<tab>',
        eol           = '<space>',
      },
    }

    require('leap').init_highlight(true)

    -- Searching in all windows (including the current one) on the tab page:
    local function get_windows_on_tabpage()
      local t = {}
      local ids = string.gmatch(vim.fn.string(vim.fn.winlayout()), "%d+")
      for id in ids do t[#t + 1] = vim.fn.getwininfo(id)[1] end
      return t
    end
    function leap_all_windows()
      require('leap').leap { ['target-windows'] = get_windows_on_tabpage() }
    end

    -- Bidirectional search in the current window is just a specific case of the
    -- multi-window mode - set `target-windows` to a table containing the current
    -- window as the only element:
    function leap_bidirectional()
      require('leap').leap {
        ['target-windows'] = { vim.fn.getwininfo(vim.fn.win_getid())[1] }
      }
    end

    -- Map them to your preferred key, like:
    vim.keymap.set('n', 's', leap_all_windows, { silent = true })
  '';



}
