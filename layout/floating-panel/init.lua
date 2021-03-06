local awful = require('awful')
local wibox = require('wibox')
local gears = require('gears')
local beautiful = require('beautiful')

local dpi = require('beautiful').xresources.apply_dpi
local clickable_container = require('widget.clickable-container')

local config_dir = gears.filesystem.get_configuration_dir()
local widget_icon_dir = config_dir .. 'layout/floating-panel/icons/'

--   ▄▄▄▄▄           ▄      ▄                 
--   █    █ ▄   ▄  ▄▄█▄▄  ▄▄█▄▄   ▄▄▄   ▄ ▄▄  
--   █▄▄▄▄▀ █   █    █      █    █▀ ▀█  █▀  █ 
--   █    █ █   █    █      █    █   █  █   █ 
--   █▄▄▄▄▀ ▀▄▄▀█    ▀▄▄    ▀▄▄  ▀█▄█▀  █   █ 


-- The button in top panel

local return_button = function()

	local widget =
		wibox.widget {
		{
			id = 'icon',
			image = widget_icon_dir .. 'notification' .. '.svg',
			widget = wibox.widget.imagebox,
			resize = true
		},
		layout = wibox.layout.align.horizontal
	}

	local clock_widget = wibox.widget.textclock(
		'<span font="SFNS Display Bold 11">%A, %I:%M %p</span>',
		1
	)

	local widget_button = wibox.widget {
		{
			clock_widget,
			margins = dpi(7),
			widget = wibox.container.margin
		},
		widget = clickable_container
	}

	widget_button:buttons(
		gears.table.join(
			awful.button(
				{},
				1,
				nil,
				function()
					awful.screen.focused().right_panel:toggle()
				end
			)
		)
	)

	return widget_button

end


return return_button
