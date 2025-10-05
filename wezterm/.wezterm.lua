package.path = package.path .. "~/.config/wezterm"

-- Pull in the wezterm API
local wezterm = require 'wezterm'

local colorJSON = io.open("/home/vinicius/.cache/wal/colors.json", "r")
if colorJSON then
  colors = require("json").decode(colorJSON:read("*a"))
  -- colors = {...colors.colors, ...colors.stecial, colors.alpha}
  io.close(colorJSON);
end

-- This table will hold the configuration.
local config = {}

-- In newer versions of wezterm, use the config_builder which will
-- help provide clearer error messages
if wezterm.config_builder then
  config = wezterm.config_builder()
end

config.window_background_opacity = 0.85
config.enable_scroll_bar = true

config.window_frame = {
  -- The font used in the tab bar.
  -- Roboto Bold is the default; this font is bundled
  -- with wezterm.
  -- Whatever font is selected here, it will have the
  -- main font setting appended to it to pick up any
  -- fallback fonts you may have used there.
  font = wezterm.font { family = 'FiraCode Nerd Font Mono', weight = 'Regular' },

  -- The size of the font in the tab bar.
  -- Default to 10.0 on Windows but 12.0 on other systems
  font_size = 12.0,

  -- The overall background color of the tab bar when
  -- the window is focused
  --active_titlebar_bg = 'rgba(20,20,20,0.4)', --'#333333',

  -- The overall background color of the tab bar when
  -- the window is not focused
  --inactive_titlebar_bg = 'rgba(20,20,20,0.4)', --'#333333',
}

-- config.colors = {
--   tab_bar = {
--     -- The color of the inactive tab bar edge/divider
--     inactive_tab_edge = '#575757',
--   },
-- }

config.colors = {
  tab_bar = {
    -- The color of the strip that goes along the top of the window
    -- (does not apply when fancy tab bar is in use)
    -- background = '#0b0022',

    -- The active tab is the one that has focus in the window
    active_tab = {
      -- The color of the background area for the tab
      bg_color = 'rgba(20,20,20,0)',--'#2b2042',
      -- The color of the text for the tab
      fg_color = '#c0c0c0',

      -- Specify whether you want "Half", "Normal" or "Bold" intensity for the
      -- label shown for this tab.
      -- The default is "Normal"
      intensity = 'Normal',

      -- Specify whether you want "None", "Single" or "Double" underline for
      -- label shown for this tab.
      -- The default is "None"
      underline = 'None',

      -- Specify whether you want the text to be italic (true) or not (false)
      -- for this tab.  The default is false.
      italic = false,

      -- Specify whether you want the text to be rendered with strikethrough (true)
      -- or not for this tab.  The default is false.
      strikethrough = false,
    },

    -- Inactive tabs are the tabs that do not have focus
    inactive_tab = {
      bg_color = 'rgba(20,20,20,0)', --'#1b1032',
      fg_color = '#808080',

      -- The same options that were listed under the active_tab section above
      -- can also be used for inactive_tab.
    },

    -- You can configure some alternate styling when the mouse pointer
    -- moves over inactive tabs
    inactive_tab_hover = {
      bg_color = 'rgba(20,20,20,0)', --'#3b3052',
      fg_color = '#909090',
      italic = true,

      -- The same options that were listed under the active_tab section above
      -- can also be used for inactive_tab_hover.
    },

    -- The new tab button that let you create new tabs
    new_tab = {
      bg_color = 'rgba(20,20,20,0)', --'#1b1032',
      fg_color = '#808080',

      -- The same options that were listed under the active_tab section above
      -- can also be used for new_tab.
    },

    -- You can configure some alternate styling when the mouse pointer
    -- moves over the new tab button
    new_tab_hover = {
      bg_color = '#3b3052',
      fg_color = '#909090',
      italic = true,

      -- The same options that were listed under the active_tab section above
      -- can also be used for new_tab_hover.
    },
  },
}

-- This is where you actually apply your config choices

config.enable_tab_bar = false
config.window_decorations = 'RESIZE'
-- config.keys = {
--   {
--     key = 'f',
--     mods = 'CTRL',
--     action = wezterm.action.ToggleFullScreen
--   }
-- }
--
-- and finally, return the configuration to wezterm
return config

