-- Pull in the wezterm API
local wezterm = require 'wezterm'

-- This table will hold the configuration.
local config = {}

-- In newer versions of wezterm, use the config_builder which will
-- help provide clearer error messages
if wezterm.config_builder then
  config = wezterm.config_builder()
end

-- config.front_end = 'WebGpu'
-- config.webgpu_power_preference = 'HighPerformance'
-- for _, gpu in ipairs(wezterm.gui.enumerate_gpus()) do
--   if gpu.device_type == "DiscreteGpu" then
--     config.webgpu_preferred_adapter = gpu
--     break
--   end
-- end

-- config.font = wezterm.font 'JetBrainsMono Nerd Font'
config.font = wezterm.font 'MonaspiceNe NF'
-- config.font = wezterm.font 'Monaspace Neon'
-- config.font = wezterm.font 'Monaspace Krypton'
config.harfbuzz_features = { "ss01", "ss02", "ss03", "ss04", "ss05", "ss06", "ss07", "ss08", "calt", "dlig" }

-- For example, changing the color scheme:
config.color_scheme = 'Catppuccin Mocha'

config.use_fancy_tab_bar = false
config.enable_tab_bar = true
-- config.enable_scroll_bar = true
config.default_domain = 'WSL:Ubuntu-20.04'

config.window_decorations = 'RESIZE'
config.window_padding = {
  left = 0,
  right = 0,
  top = 0,
  bottom = 0,
}

-- local function is_inside_vim(pane)
--   local tty = pane:get_tty_name()
--   if tty == nil then return false end
--
--   local success, _stdout, _stderr = wezterm.run_child_process
--     { 'sh', '-c',
--       'ps -o state= -o comm= -t' .. wezterm.shell_quote_arg(tty) .. ' | ' ..
--       'grep -iqE \'^[^TXZ ]+ +(\\S+\\/)?g?(view|l?n?vim?x?)(diff)?$\'' }
--   return success
-- end

-- local function is_outside_vim(pane) return not is_inside_vim(pane) end
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

config.disable_default_key_bindings = false
config.keys = {
  {key = '|', mods = 'CTRL|SHIFT', action = wezterm.action.SplitHorizontal { domain = "CurrentPaneDomain"}},
  {key = '_', mods = 'CTRL|SHIFT', action = wezterm.action.SplitVertical { domain = "CurrentPaneDomain" }},

  {key = 'h', mods = 'CTRL|SHIFT', action = wezterm.action.ActivatePaneDirection "Left"},
  {key = 'j', mods = 'CTRL|SHIFT', action = wezterm.action.ActivatePaneDirection "Down"},
  {key = 'k', mods = 'CTRL|SHIFT', action = wezterm.action.ActivatePaneDirection "Up"},
  {key = 'l', mods = 'CTRL|SHIFT', action = wezterm.action.ActivatePaneDirection "Right"},

  {key = 'h', mods = 'ALT|SHIFT', action = wezterm.action.AdjustPaneSize {"Left", 1}},
  {key = 'j', mods = 'ALT|SHIFT', action = wezterm.action.AdjustPaneSize {"Down", 1}},
  {key = 'k', mods = 'ALT|SHIFT', action = wezterm.action.AdjustPaneSize {"Up", 1}},
  {key = 'l', mods = 'ALT|SHIFT', action = wezterm.action.AdjustPaneSize {"Right", 1}},

  -- bind_if(is_outside_vim, 'h', 'CTRL', wezterm.action.ActivatePaneDirection('Left')),
  -- bind_if(is_outside_vim, 'j', 'CTRL', wezterm.action.ActivatePaneDirection('Down')),
  -- bind_if(is_outside_vim, 'k', 'CTRL', wezterm.action.ActivatePaneDirection('Up')),
  -- bind_if(is_outside_vim, 'l', 'CTRL', wezterm.action.ActivatePaneDirection('Right')),

  {key = 't', mods = 'CTRL|SHIFT', action = wezterm.action.SpawnTab "CurrentPaneDomain"},
  {key = 'q', mods = 'CTRL|SHIFT', action = wezterm.action.CloseCurrentPane {confirm = false}},

  {key = 'b', mods = 'CTRL|SHIFT', action = wezterm.action.RotatePanes "CounterClockwise"},
  {key = 'n', mods = 'CTRL|SHIFT', action = wezterm.action.RotatePanes "Clockwise"},
}

-- and finally, return the configuration to wezterm
return config
