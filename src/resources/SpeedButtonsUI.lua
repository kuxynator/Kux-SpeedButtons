data:extend({
	{
		type = "font",
		name = "bt_menu_font",
		from = "default-bold",
		size = 18
	}
})

local tbgui = {
	type="frame_style",
	--parent="frame_style",
	graphical_set = {
		--type = "monolith",
		top_monolith_border = 1,
		right_monolith_border = 1,
		bottom_monolith_border = 1,
		left_monolith_border = 1,

		border = 1,
		filename = "__Kux-SpeedButtons__/resources/GUI/50x120.png",
		position = {0, 0},
		size = 50,
		scale = 1
	}
}

local time_button = {
	type = "button_style",
	font = "default-dialog-button",
	maximal_width = 64,
	default_font_color = {r=1, g=1, b=1},
	align = "center",
	top_padding = 5,
	-- right_padding = 5,
	bottom_padding = 5,
	--  left_padding = 5,
	default_graphical_set =	{
		type = "composition",
		filename = "__Kux-SpeedButtons__/resources/GUI/gui_new_st.png",
		corner_size = {3, 3},
		position = {0, 0}
	},
	hovered_font_color={r=1, g=1, b=1},
	hovered_graphical_set =	{
		type = "composition",
		filename = "__Kux-SpeedButtons__/resources/GUI/gui_new_st.png",
		corner_size = {3, 3},
		position = {0, 8}
	},
	clicked_font_color={r=1, g=1, b=1},
	clicked_graphical_set = {
		type = "composition",
		filename = "__Kux-SpeedButtons__/resources/GUI/gui_new_st.png",
		corner_size = {3, 3},
		position = {0, 16}
	},
	pie_progress_color = {r=1, g=1, b=1}
}


local tb_textfield_style = {
	type = "textbox_style",
	left_padding = 3,
	right_padding = 2,
	minimal_width = 50,
	maximal_width = 50,
	font = "default",
	font_color = {},
	align = "center",
	graphical_set =	{
		type = "composition",
		filename = "__core__/graphics/gui.png",
		corner_size = {3, 3},
		position = {16, 0}
	},
	selection_background_color= {r=0.66, g=0.7, b=0.83}
}

local function button_graphics(xpos, ypos)
	return {
		--type = "monolith",

		top_monolith_border = 0,
		right_monolith_border = 0,
		bottom_monolith_border = 0,
		left_monolith_border = 0,

		border = 0,
		filename = "__Kux-SpeedButtons__/resources/GUI/button_all_orange.png",
		position = {xpos, ypos},
		size = 16,
		scale = 1

		--[[    monolith_image = {
		filename = "__Kux-SpeedButtons__/resources/GUI/button_all_orange.png",
		priority = "extra-high-no-scale",
		width = 16,
		height = 16,
		x = xpos,
		y = ypos,
		},]]
	}
end

local time_button_s = {
	type = "button_style",

	scalable = true,

	top_padding = 0,
	right_padding = 0,
	bottom_padding = 0,
	left_padding = 0,

	width = 16,
	height = 16,

	default_graphical_set = button_graphics( 0,  48),
	hovered_graphical_set = button_graphics(16,  48),
	clicked_graphical_set = button_graphics(32,  48),
}

local time_button_dec = {
	type = "button_style",

	scalable = true,

	top_padding = 0,
	right_padding = 0,
	bottom_padding = 0,
	left_padding = 0,

	width = 16,
	height = 16,

	default_graphical_set = button_graphics( 0,  32),
	hovered_graphical_set = button_graphics(16,  32),
	clicked_graphical_set = button_graphics(32,  32),
}

local time_button_inc = {
	type = "button_style",

	scalable = true,

	top_padding = 0,
	right_padding = 0,
	bottom_padding = 0,
	left_padding = 0,

	width = 16,
	height = 16,

	default_graphical_set = button_graphics( 0,  16),
	hovered_graphical_set = button_graphics(16,  16),
	clicked_graphical_set = button_graphics(32,  16),
}


data.raw["gui-style"].default["tb_textfield_style"] = tb_textfield_style
data.raw["gui-style"].default["tbgui"] = tbgui
data.raw["gui-style"].default["time_button"] = time_button
data.raw["gui-style"].default["time_button_s"]=time_button_s
data.raw["gui-style"].default["time_button_inc"]=time_button_inc
data.raw["gui-style"].default["time_button_dec"]=time_button_dec
