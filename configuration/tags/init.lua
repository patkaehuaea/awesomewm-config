local awful = require('awful')
local gears = require('gears')
local beautiful = require('beautiful')

local icons = require('theme.icons')

local tags = {
  {
    name = 'home',
    layout = awful.layout.suit.tile,
    type = 'home',
    defaultApp = 'Alacritty',
    screen = 1
  },
  {
    
    --name = '',
    name = 'work',
    layout = awful.layout.suit.tile,
    -- Don't think we need type.
    type = 'work',
    defaultApp = 'google-chrome',
    screen = 1
  },
  {
    --name ='﬐',
    name ='chat',
    layout = awful.layout.suit.tile,
    type = 'chat',
    defaultApp = 'slack',
    screen = 1
  },
  {
    --name ='',
    name ='code',
    layout = awful.layout.suit.tile,
    type = 'code',
    defaultApp = 'slack',
    screen = 1
  },
  {
    --name = '',
    name = 'media',
    layout = awful.layout.suit.tile,
    type = 'media',
    defaultApp = 'Spotify',
    screen = 1
  },
  {
    --name = '',
    name = 'vm',
    layout = awful.layout.suit.floating,
    type = 'virtualbox',
    defaultApp = 'virtualbox',
    screen = 1
  }
}

tag.connect_signal(
  "request::default_layouts", 
  function()
  end
)

screen.connect_signal("request::desktop_decoration", function(s)
  for i, tag in pairs(tags) do
    awful.tag.add(
      tag.name,
      {
        layout = tag.layout,
        gap_single_client = false,
        gap = beautiful.useless_gap,
        screen = s,
        defaultApp = tag.defaultApp,
        selected = i == 1
      }
    )
  end
end)

tag.connect_signal(
  'property::layout',
  function(t)
    local currentLayout = awful.tag.getproperty(t, 'layout')
    if (currentLayout == awful.layout.suit.max) then
      t.gap = 0
    else
      t.gap = beautiful.useless_gap
    end
  end
)
