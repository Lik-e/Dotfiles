----------------------
-- BATTERY WIDGET
----------------------

local charging_icon = Wibox.widget({
	markup = Helpers.text.colorize_text(Helpers.text.escape_text("󰉁"), Beautiful.yellow),
	font = Beautiful.font_icon .. "12",
	halign = "center",
	valign = "center",
	visible = false,
	widget = Wibox.widget.textbox,
})
local battery_bar = Wibox.widget({
	max_value = 100,
	value = 12,
	forced_height = Dpi(16),
	forced_width = Dpi(30),
	paddings = Dpi(2),
	border_width = 1.5,
	border_color = Beautiful.fg_normal,
	color = Beautiful.green,
	background_color = Beautiful.transparent,
	bar_shape = Helpers.shape.rrect(Dpi(2)),
	shape = Helpers.shape.rrect(Dpi(4)),
	widget = Wibox.widget.progressbar,
})
local battery_label = Wibox.widget({
	text = Helpers.misc.getCmdOut("cat /sys/class/power_supply/BAT0/capacity") .. "%",
	font = Beautiful.font_text .. "SemiBold 12",
	halign = "center",
	widget = Wibox.widget.textbox,
})

battery_bar.value = tonumber(Helpers.misc.getCmdOut("cat /sys/class/power_supply/BAT0/capacity"))

awesome.connect_signal("awesome::battery", function(capacity, charging)
	battery_label:set_text(tostring(capacity) .. "%")
	battery_bar.value = capacity
	if charging then
		charging_icon.visible = true
	else
		charging_icon.visible = false
	end
end)

return Wibox.widget({
  charging_icon,
	{
		{
			{
				battery_bar,
				{
					{
						forced_height = Dpi(10),
						forced_width = Dpi(2),
						shape = Gears.shape.rounded_bar,
						bg = Beautiful.fg_normal,
						widget = Wibox.container.background,
					},
					layout = Wibox.container.place,
				},
				spacing = Dpi(2),
				layout = Wibox.layout.fixed.horizontal,
			},
			direction = "south",
			widget = Wibox.container.rotate,
		},
		layout = Wibox.container.place,
	},
	battery_label,
	spacing = Dpi(4),
	layout = Wibox.layout.fixed.horizontal,
})
-- return Wibox.widget({
-- 	{
-- 		battery_bar,
-- 		reflection = {
-- 			horizontal = true,
-- 		},
-- 		widget = Wibox.container.mirror,
-- 	},
-- 	widget = Wibox.container.margin,
-- 	top = 4.5,
-- 	bottom = 4,
-- })
