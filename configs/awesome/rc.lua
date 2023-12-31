-- pcall(require, "luarocks.loader")

-- Standard awesome library
Gears = require("gears")
Awful = require("awful")
Wibox = require("wibox")
Beautiful = require("beautiful")
Helpers = require("utils.helpers")
Naughty = require("naughty")
Dpi = Beautiful.xresources.apply_dpi

-- Naughty error notification
Naughty.connect_signal("request::display_error", function(message, startup)
	Naughty.notification({
		urgency = "critical",
		title = "ERROR, ocurrio un problema " .. (startup and " durante en arranque!" or "!"),
		message = message,
	})
end)

-- User configuration
User = {}

User.config = {
	dark_mode = true,
	dnd_state = false,
	music_notify = true,
	modkey = "Mod4",
	theme = "onedark",
	theme_accent = "blue",
}

User.vars = {
	terminal = "kitty",
	editor = os.getenv("EDITOR") or "nano",
}

User.music_players = {
	{ player = "mpd", name = "Local", icon = "󰋎" },
	{ player = "chromium", name = "Chromium", icon = "󰇩" },
	-- { player = "firefox", name = "Firefox", icon = "󰈹" },
	{ player = "auto", name = "Auto", icon = "󰖟" },
}
User.current_player = User.music_players[1]
Playerctl = require("signal.playerctl")()

-- Desktop configuration
require("theme") -- Beautiful theme
require("config") -- AwesomeWM configuration files
require("signal") -- Awesome signal files
require("layout") -- UI configuration files
