-- time_frame
TimeView = {}

TimeView.addSpeedMenu = function()
	for index, player in pairs(game.players) do
		if player.gui.top.time_frame == nil and global.show_timer == 1 then
			player.gui.top.add({type="frame", name="time_frame", caption="",direction="vertical", style="tbgui"})--, style="tbgui"
			player.gui.top.time_frame.add{type="label", name="timeplace", caption=" "}
			player.gui.top.time_frame.timeplace.style.font="default-large-bold"
			player.gui.top.time_frame.timeplace.style.font_color = {r = 1, g = 1, b = 1}
			player.gui.top.time_frame.style.minimal_width = 80
			if debug_timebuttons == 1 then player.print("addSpeedMenu  player: " .. index, Colors.debug_color) end
		end
	end
end

TimeView.deleteSpeedMenu = function ()
	for index, player in pairs(game.players) do
		if player.gui.top.time_frame ~= nil then player.gui.top.time_frame.destroy() end
		if debug_timebuttons == 1 then player.print("deleteSpeedMenu  player: " .. index, Colors.debug_color) end
	end
end