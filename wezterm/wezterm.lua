-- Pull in the wezterm API
local wezterm = require 'wezterm'

local config = {}
if wezterm.config_builder then
  config = wezterm.config_builder()
end

-- config.font = wezterm.font 'JetBrainsMono Nerd Font'
-- config.font = wezterm.font 'MonaspiceNe NF'
-- config.font = wezterm.font 'MonaspiceKr NF'
config.font = wezterm.font 'Monaspace Neon'

config.harfbuzz_features = { "ss01", "ss02", "ss03", "ss04", "ss05", "ss06", "ss07", "ss08", "ss09", "calt", "dlig", "liga" }

-- For example, changing the color scheme:
-- config.color_scheme = 'Catppuccin Mocha'
-- config.color_scheme = 'Gruvbox Dark (Gogh)'
-- config.color_scheme = 'nord'
-- config.color_scheme = 'Ayu Mirage'
config.color_scheme = 'kanagawabones'

config.colors = {
  tab_bar = {
    background = '#1F1F28',
    active_tab = {
      bg_color = '#2A2A37',
      fg_color = '#DCD7BA',
    },
    inactive_tab = {
      bg_color = '#1F1F28',
      fg_color = '#DCD7BA',
    },
    inactive_tab_hover = {
      bg_color = '#2A2A37',
      fg_color = '#DCD7BA',
    },
    new_tab = {
      bg_color = '#1F1F28',
      fg_color = '#DCD7BA',
    },
    new_tab_hover = {
      bg_color = '#2A2A37',
      fg_color = '#DCD7BA',
    },
  }
}

config.window_background_opacity = 0.99
config.macos_window_background_blur = 50
config.inactive_pane_hsb = {
  saturation = 0.9,
  brightness = 0.5,
}

config.use_fancy_tab_bar = false
-- config.enable_tab_bar = true
config.enable_tab_bar = false
config.max_fps = 120
-- config.enable_scroll_bar = true

local background = wezterm.home_dir .. '/.config/wezterm/eclipse.jpg'
if wezterm.target_triple == 'x86_64-pc-windows-msvc' then
  config.default_domain = 'WSL:Ubuntu-20.04'
  background = 'c:/Users/RAald/eclipse.jpg'
end

config.background = {
  {
    source = {File=background},
    vertical_align="Middle",
    -- hsb={brightness=0.01},
  },
  {
    source = {Color='#1F1F28'},
    width="100%",
    height="100%",
    opacity=0.9,
  }
}

-- config.window_background_gradient = {
--   colors = { '#1F1F28', '#1a1a22' },
--   -- Specifices a Linear gradient starting in the top left corner.
--   orientation = { Linear = { angle = -45.0 } },
-- }

config.window_decorations = 'RESIZE'
config.window_padding = {
  left = 6,
  right = 6,
  top = 6,
  bottom = 6,
}

-- local function is_vim(pane)
--   -- this is set by the plugin, and unset on ExitPre in Neovim
--   return pane:get_user_vars().IS_NVIM == 'true'
-- end
--
-- local function is_outside_vim(pane) return not is_vim(pane) end
--
-- local function bind_if(cond, key, mods, action)
--   local function callback (win, pane)
--     if cond(pane) then
--       win:perform_action(action, pane)
--     else
--       win:perform_action(wezterm.action.SendKey({key=key, mods=mods}), pane)
--     end
--   end
--
--   return {key=key, mods=mods, action=wezterm.action_callback(callback)}
-- end

config.disable_default_key_bindings = true
config.keys = {
  -- {key = '|', mods = 'CTRL|SHIFT', action = wezterm.action.SplitHorizontal { domain = "CurrentPaneDomain"}},
  -- {key = '_', mods = 'CTRL|SHIFT', action = wezterm.action.SplitVertical { domain = "CurrentPaneDomain" }},
  --
  -- -- {key = 'h', mods = 'CTRL|SHIFT', action = wezterm.action.ActivatePaneDirection "Left"},
  -- -- {key = 'j', mods = 'CTRL|SHIFT', action = wezterm.action.ActivatePaneDirection "Down"},
  -- -- {key = 'k', mods = 'CTRL|SHIFT', action = wezterm.action.ActivatePaneDirection "Up"},
  -- -- {key = 'l', mods = 'CTRL|SHIFT', action = wezterm.action.ActivatePaneDirection "Right"},
  --
  -- {key = 'h', mods = 'ALT|SHIFT', action = wezterm.action.AdjustPaneSize {"Left", 1}},
  -- {key = 'j', mods = 'ALT|SHIFT', action = wezterm.action.AdjustPaneSize {"Down", 1}},
  -- {key = 'k', mods = 'ALT|SHIFT', action = wezterm.action.AdjustPaneSize {"Up", 1}},
  -- {key = 'l', mods = 'ALT|SHIFT', action = wezterm.action.AdjustPaneSize {"Right", 1}},
  --
  -- bind_if(is_outside_vim, 'h', 'CTRL|SHIFT', wezterm.action.ActivatePaneDirection('Left')),
  -- bind_if(is_outside_vim, 'j', 'CTRL|SHIFT', wezterm.action.ActivatePaneDirection('Down')),
  -- bind_if(is_outside_vim, 'k', 'CTRL|SHIFT', wezterm.action.ActivatePaneDirection('Up')),
  -- bind_if(is_outside_vim, 'l', 'CTRL|SHIFT', wezterm.action.ActivatePaneDirection('Right')),
  --
  -- {key = 't', mods = 'CTRL|SHIFT', action = wezterm.action.SpawnTab "CurrentPaneDomain"},
  -- {key = 'q', mods = 'CTRL|SHIFT', action = wezterm.action.CloseCurrentPane {confirm = false}},
  --
  -- {key = 'b', mods = 'CTRL|SHIFT', action = wezterm.action.RotatePanes "CounterClockwise"},
  -- {key = 'n', mods = 'CTRL|SHIFT', action = wezterm.action.RotatePanes "Clockwise"},
  {key = 'v', mods = 'CTRL|SHIFT', action = wezterm.action.PasteFrom 'Clipboard'},
  {key = 'Insert', mods = 'SHIFT', action = wezterm.action.PasteFrom 'Clipboard'},

}

-- fix ctrl-shift
config.enable_kitty_keyboard = true

-- and finally, return the configuration to wezterm
return config
