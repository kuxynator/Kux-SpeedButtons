-- tb_frame

ButtonsView = {}

ButtonsView.addButtons = function()
	--add_time_menu()
	for index, player in pairs(game.players) do

		if player.gui.top.tb_frame ~= nil then goto next end

		player.gui.top.add({type="frame", name="tb_frame", caption="",direction="horizontal", style="tbgui"}) --, style="tbgui"

		for i=1, global.button_count, 1 do
			if player.gui.top.tb_frame ~= nil then
				player.gui.top.tb_frame.add({type = "button", name="timebutton" .. i, caption=global.button_caption[i], fontcolor = Colors.white, style="time_button"})
			end
		end

		player.gui.top.tb_frame.add({type = "button", name="settingsbutton", caption="", fontcolor = Colors.white, style="time_button_s"})

		player.gui.top.tb_frame.add{type="label", name="cur_speed", caption=" "}
		player.gui.top.tb_frame.cur_speed.style.font="default-large-bold"
		player.gui.top.tb_frame.cur_speed.style.font_color = {r = 1, g = 1, b = 1}
		--player.gui.top.tb_frame.style.minimal_width = 80

		ButtonsView.detect_speed_color_red()

		if debug_timebuttons == 1 then player.print("add_buttons  player: " .. index, Colors.debug_color) end
		::next::
	end
end

ButtonsView.addButtonsForPlayer = function(player) -- TODO not used ???
	if player.gui.top.tb_frame ~= nil then return end
	player.gui.top.add({type="frame", name="tb_frame", caption="",direction="horizontal", style="tbgui"}) --, style="tbgui" , style="tbgui"

	for i=1, global.button_count, 1 do
		if player.gui.top.tb_frame ~= nil then
			player.gui.top.tb_frame.add({type = "button", name="timebutton" .. i, caption=global.button_caption[i], fontcolor = Colors.white, style="time_button"})
		end
	end

	player.gui.top.tb_frame.add({type = "button", name="settingsbutton", caption="", fontcolor = Colors.white, style="time_button_s"})
	ButtonsView.detect_speed_color_red()
end

ButtonsView.deleteAll = function ()
	for index, player in pairs(game.players) do
		if player.gui.top.tb_frame ~= nil then player.gui.top.tb_frame.destroy() end
		if debug_timebuttons == 1 then player.print("delete_all  player: " .. index, Colors.debug_color) end
	end
end

ButtonsView.deleteAllForPlayer = function (player)
	if player.gui.top.tb_frame ~= nil then player.gui.top.tb_frame.destroy() end
	--player.print("Delete ALL")
end

function ButtonsView.all_yellow()
	for _, player in pairs(game.players) do	
		for i=1, global.button_count, 1 do
			if player.gui.top.tb_frame ~= nil then
				player.gui.top.tb_frame["timebutton" .. i].style.font_color = Colors.yellow
				player.gui.top.tb_frame.cur_speed.caption = " x" .. game.speed
				speed_detected = true
			end
		end
		player.print("Game speed : " .. game.speed)
	end
end

function ButtonsView.all_white()
	for index, player in pairs(game.players) do
		for i=1, global.button_count, 1 do
			if player.gui.top.tb_frame ~= nil then
				--player.print("i=" .. i)
				player.gui.top.tb_frame["timebutton" .. i].style.font_color = Colors.white
				speed_detected = true
			end
		end
	end
end

function ButtonsView.detect_speed_color_red()
	speed_detected = false

	ButtonsView.all_white()

	for _, player in pairs(game.players) do
		for i=1, global.button_count, 1 do
			if game.speed == global.button_speed[i] then
				if player.gui.top.tb_frame ~= nil then
					player.gui.top.tb_frame["timebutton" .. i].style.font_color = Colors.red
					--player.gui.top.tb_frame.cur_speed.caption = " "
					speed_detected = true
				end
			end
		end
	end

	for _, player in pairs(game.players) do	
		if player.gui.top.tb_frame ~= nil then
			player.gui.top.tb_frame.cur_speed.caption = " "
		end
	end

	if speed_detected == false then
		ButtonsView.all_yellow()
	end
end