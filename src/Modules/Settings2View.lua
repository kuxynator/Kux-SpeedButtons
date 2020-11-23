-- menu_tb_2

Settings2View = {}

function Settings2View.drawSpeedMenu2ForPlayer(player)
	if player.gui.top.menu_tb_2 ~= nil then return end

	player.gui.top.add({type="frame", name="menu_tb_2", caption="",direction="vertical"})
	player.gui.top.menu_tb_2.add({type="flow",name="row_title",direction="horizontal"})
	player.gui.top.menu_tb_2.row_title.add({type="label", name="label_menu_title", caption="          Speed Buttons Sub Menu    "})
	player.gui.top.menu_tb_2.add({type="flow",name="row_0",direction="horizontal"})
	player.gui.top.menu_tb_2.row_0.add({type="label", name="label_menu_0", caption="min. speed change time:"})
	player.gui.top.menu_tb_2.row_0.add({type="textfield", name="min_speed", caption="", text="", style="tb_textfield_style"})

	if global.min_time_tmp ~= global.min_time then
		player.gui.top.menu_tb_2.row_0.min_speed.text=global.min_time_tmp
	else
		player.gui.top.menu_tb_2.row_0.min_speed.text=global.min_time
	end

	--min_time_tmp
	--global.min_time
	-- min. speed change time
end

function Settings2View.deleteSpeedMenu2()
	for index, player in pairs(game.players) do
		if player.gui.top.menu_tb_2 ~= nil then player.gui.top.menu_tb_2.destroy() end
		if debug_timebuttons == 1 then player.print("deleteSpeedMenu2  player: " .. index, Colors.debug_color) end
	end
end

function Settings2View.deleteSpeedMenu2ForPlayer(player)
	if player.gui.top.menu_tb_2 ~= nil then player.gui.top.menu_tb_2.destroy() end
end