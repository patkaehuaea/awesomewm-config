local filesystem = require('gears.filesystem')
local config_dir = filesystem.get_configuration_dir()


return {
	-- The default applications in keybindings and widgets
	default = {
		terminal = 'alacritty',                                  -- Terminal Emulator
		text_editor = 'vim',                                  -- GUI Text Editor
		web_browser = 'firefox',                                -- Web browser
		file_manager = 'ranger',                                -- GUI File manager
		network_manager = 'networkmanager_dmenu',					-- Network manager
		bluetooth_manager = 'blueman-manager',						-- Bluetooth manager
		lock = 'xflock4',  -- Lockscreen
		package_manager = 'pamac-manager',							-- GUI Package manager
		rofiappmenu = 
		  'rofi -dpi ' 
		  .. screen.primary.dpi 
		  .. ' -show drun -theme ' 
		  .. config_dir 
		  .. 'configuration/rofi/appmenu/nord.rasi'
	},
}
