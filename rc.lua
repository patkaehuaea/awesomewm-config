
--     ▄▄                                            ▄     ▄ ▄    ▄
--     ██  ▄     ▄  ▄▄▄    ▄▄▄    ▄▄▄   ▄▄▄▄▄   ▄▄▄  █  █  █ ██  ██
--    █  █ ▀▄ ▄ ▄▀ █▀  █  █   ▀  █▀ ▀█  █ █ █  █▀  █ ▀ █▀█ █ █ ██ █
--    █▄▄█  █▄█▄█  █▀▀▀▀   ▀▀▀▄  █   █  █ █ █  █▀▀▀▀  ██ ██▀ █ ▀▀ █
--   █    █  █ █   ▀█▄▄▀  ▀▄▄▄▀  ▀█▄█▀  █ █ █  ▀█▄▄▀  █   █  █    █

-- Banner generated using `toilet -f mono9 AwesomeWM"

local gears = require('gears')
local awful = require('awful')
local lain = require('lain')
local beautiful = require('beautiful')

require('awful.autofocus')

--  ========================================
--             Theme
--        Load the Aesthetics
--  ========================================
beautiful.init(require('theme'))

--  ========================================
--            Layouts
--           Load the Panels
--  ========================================

require('layout')

--  ========================================
--            Modules
--          Load all the modules
--  ========================================

require('module.notifications')
require('module.decorate-client')
require('module.backdrop')
require('module.end-session')
require('module.menu')
require('module.volume-osd')

--  ========================================
--        Configuration
--        Load your prefrences
--  ========================================

require('configuration.client')
require('configuration.tags')
root.keys(require('configuration.keys.global'))


--  ========================================
--        Layouts 
--        Set default layouts and config
--  ========================================


awful.layout.layouts = {
  awful.layout.suit.tile,
  awful.layout.suit.floating,
  awful.layout.suit.magnifier,
  lain.layout.centerwork,
  lain.layout.termfair.center,
}

lain.layout.termfair.center.nmaster = 3
lain.layout.termfair.center.ncol    = 1

--  ========================================
--          Signals
--       Signals Listeners and Senders
--  ========================================

screen.connect_signal("request::wallpaper", function(s)

  -- If wallpaper is a function, call it with the screen
  if beautiful.wallpaper then
    if type(beautiful.wallpaper) == "string" then
      if beautiful.wallpaper:sub(1, #"#") == "#" then
          gears.wallpaper.set(beautiful.wallpaper)
      elseif beautiful.wallpaper:sub(1, #"/") == "/" then
          gears.wallpaper.maximized(beautiful.wallpaper, s)
      end
    else
      beautiful.wallpaper(s)
    end
  end

end)

-- Signal function to execute when a new client appears.
client.connect_signal(
  'manage',
  function(c)
    -- Set the windows at the slave,
    -- i.e. put it at the end of others instead of setting it master.
    if not _G.awesome.startup then
      awful.client.setslave(c)
    end

    if _G.awesome.startup and not c.size_hints.user_position and not c.size_hints.program_position then
      -- Prevent clients from being unreachable after screen count changes.
      awful.placement.no_offscreen(c)
    end
  end
)

-- Enable sloppy focus, so that focus follows mouse.
client.connect_signal(
  'mouse::enter',
  function(c)
    c:emit_signal('request::activate', 'mouse_enter', {raise = true})
  end
)

client.connect_signal(
  'focus',
  function(c)
    c.border_color = beautiful.border_focus
  end
)

client.connect_signal(
  'unfocus',
  function(c)
    c.border_color = beautiful.border_normal
  end
)
