-- menu_tb

SettingsView = {}

SettingsView.drawSpeedMenu = function()
	for _, player in pairs(game.players) do
		--player.print("Draw Time Menu")
		if player.gui.top.menu_tb ~= nil then goto next end

		player.gui.top.add({type="frame", name="menu_tb", caption="            Speed Buttons Menu", direction="vertical"})
		--game.player.gui.top.menu_tb.style.align = "center"

		player.gui.top.menu_tb.add({type="flow",name="row_0",direction="horizontal"})
		player.gui.top.menu_tb.row_0.add({type="label", name="label_menu_0", caption="Number of speed buttons:"})
		player.gui.top.menu_tb.row_0.add({type="textfield", name="text_noofbuttons", caption="", style="tb_textfield_style"})
			player.gui.top.menu_tb.row_0.text_noofbuttons.caption = global.button_count
		--player.gui.top.menu_tb.row_0.add({type="button", name="timedec", caption=" - "})
		--player.gui.top.menu_tb.row_0.add({type="button", name="timeinc", caption=" + "})
		player.gui.top.menu_tb.row_0.add({type="button", name="timedec", caption="",style="time_button_dec"})
		player.gui.top.menu_tb.row_0.add({type="button", name="timeinc", caption="",style="time_button_inc"})
		--mw = 35
		--player.gui.top.menu_tb.row_0.timeinc.style.maximal_width=mw
		--player.gui.top.menu_tb.row_0.timeinc.style.minimal_width=mw
		--player.gui.top.menu_tb.row_0.timedec.style.maximal_width=mw
		--player.gui.top.menu_tb.row_0.timedec.style.minimal_width=mw	

		player.gui.top.menu_tb.add({type="flow",name="row_1",direction="horizontal"})
		player.gui.top.menu_tb.row_1.add({type="label", name="label_menu_0", caption=" "})
		player.gui.top.menu_tb.row_1.add({type="label", name="label_menu_1", caption="Name"})
		player.gui.top.menu_tb.row_1.add({type="label", name="label_menu_4", caption=" "})
		player.gui.top.menu_tb.row_1.add({type="label", name="label_menu_2", caption="Speed"})
	--  game.player.gui.top.menu_tb.row_1.add({type="label", name="label_menu_5", caption=" "})
	--	game.player.gui.top.menu_tb.row_1.add({type="label", name="label_menu_3", caption="ON/OFF"})
		player.gui.top.menu_tb.row_1.label_menu_1.style.font="default-bold"
		player.gui.top.menu_tb.row_1.label_menu_2.style.font="default-bold"
	--	game.player.gui.top.menu_tb.row_1.label_menu_3.style.font="default-bold"
		player.gui.top.menu_tb.row_1.label_menu_0.style.minimal_width=81
		player.gui.top.menu_tb.row_1.label_menu_1.style.minimal_width=40
		player.gui.top.menu_tb.row_1.label_menu_2.style.minimal_width=40
	--	game.player.gui.top.menu_tb.row_1.label_menu_3.style.minimal_width=40
		player.gui.top.menu_tb.row_1.label_menu_4.style.minimal_width=33
	--	game.player.gui.top.menu_tb.row_1.label_menu_5.style.minimal_width=21

		for i=1, global.button_count, 1 do
			local row_no = i+1
			player.gui.top.menu_tb.add({type="flow",name="row_" .. row_no,direction="horizontal"})
			player.gui.top.menu_tb["row_" .. row_no].add({type="label", name="label_menu_4", caption="Button " .. i .. ":"})
			player.gui.top.menu_tb["row_" .. row_no].add({type="textfield", name="text_menu_0_" .. i, caption="", style="tb_textfield_style"}) -- style="textfield_style"})
			player.gui.top.menu_tb["row_" .. row_no].add({type="textfield", name="text_menu_1_" .. i, caption="", style="tb_textfield_style"})
			player.gui.top.menu_tb["row_" .. row_no].label_menu_4.style.font="default-bold"
			local mw=80
			player.gui.top.menu_tb["row_" .. row_no]["text_menu_0_" .. i].style.maximal_width=mw
			player.gui.top.menu_tb["row_" .. row_no]["text_menu_1_" .. i].style.maximal_width=mw
			player.gui.top.menu_tb["row_" .. row_no]["text_menu_0_" .. i].style.minimal_width=mw
			player.gui.top.menu_tb["row_" .. row_no]["text_menu_1_" .. i].style.minimal_width=mw
			mw=34
			player.gui.top.menu_tb["row_" .. row_no]["text_menu_0_" .. i].style.minimal_height=mw
			player.gui.top.menu_tb["row_" .. row_no]["text_menu_1_" .. i].style.minimal_height=mw
			player.gui.top.menu_tb["row_" .. row_no]["text_menu_0_" .. i].caption = global.button_caption[i]
			player.gui.top.menu_tb["row_" .. row_no]["text_menu_1_" .. i].caption = global.button_speed[i]
			player.gui.top.menu_tb["row_" .. row_no]["text_menu_0_" .. i].text = global.button_caption[i]
			player.gui.top.menu_tb["row_" .. row_no]["text_menu_1_" .. i].text = global.button_speed[i]
		end

		player.gui.top.menu_tb.add({type="flow",name="row_preend1",direction="horizontal"})
		player.gui.top.menu_tb.row_preend1.add({type="checkbox", name="CheckBoxtb_row_preend2", caption="Check me and when you start crafting game", state=false})
		if global.chspeedoncraftingonoff == false then player.gui.top.menu_tb.row_preend1.CheckBoxtb_row_preend2.state = false
		elseif global.chspeedoncraftingonoff == true then player.gui.top.menu_tb.row_preend1.CheckBoxtb_row_preend2.state = true
		end

		player.gui.top.menu_tb.add({type="flow",name="row_preend2",direction="horizontal"})
		player.gui.top.menu_tb.row_preend2.add({type="label", name="label_menu_10", caption="speed will change to:"})				
		player.gui.top.menu_tb.row_preend2.add({type="textfield", name="tbtfield1", caption="", style="tb_textfield_style"})
		player.gui.top.menu_tb.row_preend2.add({type="label", name="label_menu_11", caption="and after crafting is"})
		player.gui.top.menu_tb.row_preend2.tbtfield1.caption = global.speedatcrafting

		player.gui.top.menu_tb.add({type="flow",name="row_preend3",direction="vertical"})
		player.gui.top.menu_tb.row_preend3.add({type="label", name="label_menu_12", caption="finished it will return to previous value unless you"})
		player.gui.top.menu_tb.row_preend3.add({type="label", name="label_menu_13", caption="change game speed during crafting/mining."})

		player.gui.top.menu_tb.add({type="flow",name="row_end",direction="horizontal"})
		player.gui.top.menu_tb.row_end.add({type="button", name="time_button_menu_end", caption="SAVE AND CLOSE"})
		player.gui.top.menu_tb.row_end.time_button_menu_end.style.font="default-bold"
		local mw=315
		player.gui.top.menu_tb.row_end.time_button_menu_end.style.maximal_width=mw
		player.gui.top.menu_tb.row_end.time_button_menu_end.style.minimal_width=mw
		::next::
	end
end

SettingsView.drawSpeedMenuForPlayer = function (player)

	--player.print("Draw Speed Menu")
	if player.gui.top.menu_tb ~= nil then return end

	player.gui.top.add({type="frame", name="menu_tb", caption="",direction="vertical"}) --            Speed Buttons Menu

	player.gui.top.menu_tb.add({type="flow",name="row_title",direction="horizontal"})
	player.gui.top.menu_tb.row_title.add({type="label", name="label_menu_title", caption="            Speed Buttons Menu     "})
	player.gui.top.menu_tb.row_title.label_menu_title.style.font="bt_menu_font"
	player.gui.top.menu_tb.row_title.add({type = "button", name="settingsbutton_2", caption="", fontcolor = Colors.white, style="time_button_s"})

	player.gui.top.menu_tb.add({type="flow",name="row_0",direction="horizontal"})
	player.gui.top.menu_tb.row_0.add({type="label", name="label_menu_0", caption="Number of speed buttons:"})
	player.gui.top.menu_tb.row_0.add({type="textfield", name="text_noofbuttons", caption="", style="tb_textfield_style"})
	player.gui.top.menu_tb.row_0.text_noofbuttons.caption = global.button_count
	player.gui.top.menu_tb.row_0.add({type="button", name="timedec", caption="", style="time_button_dec"})
	player.gui.top.menu_tb.row_0.add({type="button", name="timeinc", caption="", style="time_button_inc"})

	player.gui.top.menu_tb.add({type="flow",name="row_1",direction="horizontal"})
	player.gui.top.menu_tb.row_1.add({type="label", name="label_menu_0", caption=" "})
	player.gui.top.menu_tb.row_1.add({type="label", name="label_menu_1", caption="Name"})
	player.gui.top.menu_tb.row_1.add({type="label", name="label_menu_4", caption=" "})
	player.gui.top.menu_tb.row_1.add({type="label", name="label_menu_2", caption="Speed"})
	--game.player.gui.top.menu_tb.row_1.add({type="label", name="label_menu_5", caption=" "})
--	game.player.gui.top.menu_tb.row_1.add({type="label", name="label_menu_3", caption="ON/OFF"})
	player.gui.top.menu_tb.row_1.label_menu_1.style.font="default-bold"
	player.gui.top.menu_tb.row_1.label_menu_2.style.font="default-bold"
--	game.player.gui.top.menu_tb.row_1.label_menu_3.style.font="default-bold"
	player.gui.top.menu_tb.row_1.label_menu_0.style.minimal_width=81
	player.gui.top.menu_tb.row_1.label_menu_1.style.minimal_width=40
	player.gui.top.menu_tb.row_1.label_menu_2.style.minimal_width=40
--	game.player.gui.top.menu_tb.row_1.label_menu_3.style.minimal_width=40
	player.gui.top.menu_tb.row_1.label_menu_4.style.minimal_width=33
--	game.player.gui.top.menu_tb.row_1.label_menu_5.style.minimal_width=21

	print("drawSpeedMenuForPlayer: global.button_count="..tostring(global.button_count))
	for i=1, global.button_count, 1 do
		print("drawSpeedMenuForPlayer: button "..tostring(i))
		print("drawSpeedMenuForPlayer: global.button_caption[i] "..global.button_caption[i])
		print("drawSpeedMenuForPlayer: global.button_speed[i] "..global.button_speed[i])
		local row_no = i+1
		local row = player.gui.top.menu_tb.add({type="flow",name="row_" .. row_no,direction="horizontal"})
		--local row = player.gui.top.menu_tb["row_" .. row_no]
		row.add({type="label", name="label_menu_4", caption="Button " .. i .. ":"})
		row.add({type="textfield", name="text_menu_0_" .. i, caption="", style="tb_textfield_style"})
		row.add({type="textfield", name="text_menu_1_" .. i, caption="", style="tb_textfield_style"})
		row["label_menu_4"].style.font="default-bold"
		local mw=80
		row["text_menu_0_" .. i].style.maximal_width=mw
		row["text_menu_1_" .. i].style.maximal_width=mw
		row["text_menu_0_" .. i].style.minimal_width=mw
		row["text_menu_1_" .. i].style.minimal_width=mw
		mw=34
		row["text_menu_0_" .. i].style.minimal_height=mw
		row["text_menu_1_" .. i].style.minimal_height=mw
		row["text_menu_0_" .. i].caption = global.button_caption[i]
		row["text_menu_1_" .. i].caption = global.button_speed[i]
		if global.button_caption[i] ~= nil then row["text_menu_0_" .. i].text = global.button_caption[i] end
		if global.button_speed[i] ~= nil then row["text_menu_1_" .. i].text = tostring(global.button_speed[i]) end
	end

	player.gui.top.menu_tb.add({type="flow",name="row_preend0",direction="vertical"})
	player.gui.top.menu_tb.row_preend0.add({type="checkbox", name="CheckBoxtb_row_preend0", caption="Show/Hide Clock", state=false})
	if global.show_timer == 0 then player.gui.top.menu_tb.row_preend0.CheckBoxtb_row_preend0.state = false
	elseif global.show_timer == 1 then player.gui.top.menu_tb.row_preend0.CheckBoxtb_row_preend0.state = true
	end

	player.gui.top.menu_tb.add({type="flow",name="row_preend1",direction="horizontal"})
	player.gui.top.menu_tb.row_preend1.add({type="checkbox", name="CheckBoxtb_row_preend2", caption="Check me and when you start crafting", state=false})
	if     global.chspeedoncraftingonoff == false then player.gui.top.menu_tb.row_preend1.CheckBoxtb_row_preend2.state = false
	elseif global.chspeedoncraftingonoff == true then player.gui.top.menu_tb.row_preend1.CheckBoxtb_row_preend2.state = true
	end

	player.gui.top.menu_tb.add({type="flow",name="row_preend1b",direction="horizontal"})
	player.gui.top.menu_tb.row_preend1b.add({type="checkbox", name="CheckBoxtb_row_preend1b", caption="Check me and when you start mining", state=false})
	if global.chspeedonminingonoff == false then player.gui.top.menu_tb.row_preend1b.CheckBoxtb_row_preend1b.state = false
	elseif global.chspeedonminingonoff == true then player.gui.top.menu_tb.row_preend1b.CheckBoxtb_row_preend1b.state = true
	end

	player.gui.top.menu_tb.add({type="flow",name="row_preend2",direction="horizontal"})
	player.gui.top.menu_tb.row_preend2.add({type="label", name="label_menu_10", caption="game speed will change to:"})				
	player.gui.top.menu_tb.row_preend2.add({type="textfield", name="tbtfield1", caption="", style="tb_textfield_style"})
	--player.gui.top.menu_tb.row_preend2.add({type="label", name="label_menu_11", caption="and after crafting is"})
	player.gui.top.menu_tb.row_preend2.tbtfield1.caption = global.speedatcrafting
	player.gui.top.menu_tb.row_preend2.tbtfield1.style.minimal_width=70

	player.gui.top.menu_tb.add({type="flow",name="row_preend2b",direction="vertical"})
	player.gui.top.menu_tb.row_preend2b.add({type="label", name="label_menu_11", caption="and after crafting is finished it will return"})

	player.gui.top.menu_tb.add({type="flow",name="row_preend3",direction="vertical"})
	player.gui.top.menu_tb.row_preend3.add({type="label", name="label_menu_12", caption="to previous value unless you change"})
	player.gui.top.menu_tb.row_preend3.add({type="label", name="label_menu_13", caption="game speed during crafting/mining."})

	--[[
	player.gui.top.menu_tb.add({type="flow",name="row_preend5",direction="horizontal"})
	player.gui.top.menu_tb.row_preend5.add({type="label", name="label_menu_14", caption="game speed... blah blah ...:"})				
	player.gui.top.menu_tb.row_preend5.add({type="textfield", name="tbtfield2", caption="", style="tb_textfield_style"})
		player.gui.top.menu_tb.row_preend5.tbtfield2.caption = global.speedatcrafting
		player.gui.top.menu_tb.row_preend5.tbtfield2.style.minimal_width=70
	]]--

	player.gui.top.menu_tb.add({type="flow",name="row_end",direction="horizontal"})
	player.gui.top.menu_tb.row_end.add({type="button", name="time_button_menu_end", caption="SAVE AND CLOSE", style="time_button"})
	player.gui.top.menu_tb.row_end.time_button_menu_end.style.font="default-bold"
	local mw=245
	player.gui.top.menu_tb.row_end.time_button_menu_end.style.maximal_width=mw
	player.gui.top.menu_tb.row_end.time_button_menu_end.style.minimal_width=mw
end

