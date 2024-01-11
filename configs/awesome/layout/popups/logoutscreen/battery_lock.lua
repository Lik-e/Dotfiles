local battery_bar = Wibox.widget({
	max_value = 100,
	value = 40,
	forced_height = Dpi(25),
	forced_width = Dpi(70),
	paddings = 0,
	border_width = 0,
	border_color = Beautiful.fg_normal,
	color = Beautiful.cyan,
	background_color = Beautiful.cyan .. "4F",
	bar_shape = Gears.shape.rounded_bar,
	shape = Gears.shape.rounded_bar,
	widget = Wibox.widget.progressbar,
})

local battery_label = Wibox.widget({
	text = Helpers.getCmdOut("cat /sys/class/power_supply/BAT0/capacity") .. "%",
	font = "Rubik Regular 13",
	halign = "center",
	widget = Wibox.widget.textbox,
})

battery_bar.value = tonumber(Helpers.getCmdOut("cat /sys/class/power_supply/BAT0/capacity"))

awesome.connect_signal("awesome::battery", function(capacity, charging)
	battery_label:set_text(tostring(capacity) .. "%")
	battery_bar.value = capacity
end)

local battery = Wibox.widget({
	layout = Wibox.layout.fixed.horizontal,
	spacing = Dpi(10),
	{
		widget = Wibox.widget.imagebox,
		image = Beautiful.user_icon,
		clip_shape = Gears.shape.circle,
		halign = "center",
		valign = "center",
		forced_height = Dpi(45),
		forced_width = Dpi(45),
	},
  {
    layout = Wibox.container.place,
    battery_bar,
  },
	battery_label,
})

return battery