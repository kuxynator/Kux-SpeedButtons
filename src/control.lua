
require "__Kux-CoreLib__/lib/lua"
require "Modules.Colors"
require "Modules.GameSpeed"

require "Modules.SettingsView"		-- menu_tb
require "Modules.Settings2View"		-- menu_tb_2
require "Modules.ButtonsView"		-- tb_frame
require "Modules.TimeView"			-- time_frame

init = 0
debug_timebuttons = 0

local function initGlobals()
	if global.button_count == nil           then global.button_count = 5	end
	if global.button_caption == nil         then global.button_caption = {"x0.5", "x1", "x2", "x3", "x5"} end
	if global.button_speed == nil           then global.button_speed = {0.5, 1, 2 ,3 ,5} end
	if global.button_menu_timer == nil      then global.button_menu_timer = 0 end
	if global.chspeedoncraftingonoff == nil then global.chspeedoncraftingonoff = false end
	if global.chspeedonminingonoff == nil   then global.chspeedonminingonoff = false end
	if global.speedatcrafting == nil        then global.speedatcrafting = 2 end
	if global.speedatstartcrafting == nil   then global.speedatstartcrafting = 0 end
	-- if global.timebuttons_compatibility == nil then global.timebuttons_compatibility = {false,false} end
	if global.show_timer == nil             then global.show_timer = 1 end
	if global.min_time == nil               then global.min_time = 60	--[[in game ticks... 60ticks= 1 second]] end
	if global.timer_1 == nil                then global.timer_1 = 0 --[[in game ticks... 60ticks= 1 second]] end

	--TODO revise
 	if global.min_time_tmp == nil then
		for name, version in pairs(game.active_mods) do
			if name == "TimeButtons" then
				if version == "0.3.5" then
					global.min_time = 20
				end
			end
		end

		global.min_time_tmp = global.min_time	--in game ticks... 60 ticks= 1 second
	end

 	if global.max_speed == nil or global.max_speed ~= 256 then global.max_speed = 256 end
  	if global.min_speed == nil or global.min_speed ~= 0.125 then global.min_speed = 0.125 end
end

local this = nil
local control = {

	on_init = function()
		initGlobals()

		ButtonsView.deleteAll()
		TimeView.deleteSpeedMenu()
		TimeView.addSpeedMenu()
		ButtonsView.addButtons()

		if debug_timebuttons == 1 then
			for _, player in pairs(game.players) do
				if player.connected then
					player.print("on_init ", Colors.debug_color)
				end
			end
		end
	 end,

	 on_configuration_changed = function()
		initGlobals()

		ButtonsView.deleteAll()
		TimeView.deleteSpeedMenu()
		TimeView.addSpeedMenu()
		ButtonsView.addButtons()

		if debug_timebuttons == 1 then
			for _, player in pairs(game.players) do
				if player.connected then
					player.print("on_configuration_changed ", Colors.debug_color)
				end
			end
		end	
	end,

	on_player_created = function(event)

		if debug_timebuttons == 1 then
			for _, player in pairs(game.players) do
				if player.connected then
					player.print("START on_player_created", Colors.debug_color)
				end
			end
		end

		ButtonsView.deleteAll()
		TimeView.deleteSpeedMenu()
		TimeView.addSpeedMenu()
		ButtonsView.addButtons()

		if debug_timebuttons == 1 then
			for _, player in pairs(game.players) do
				if player.connected then
					player.print("END on_player_created", Colors.debug_color)
				end
			end
		end	
	end,

	on_gui_click = function(event)
		-- handle on gui click
		--game.player.print(event.element.name)

		-- #region operation of speed buttons

		local x1,y1 = string.find(event.element.name, "timebutton")
		if x1 ~= nil then
			local button_no = tonumber(string.sub(event.element.name, y1+1))      -- from character 7 until the end
			local button_speed = global.button_speed[button_no]
			if button_speed ~= nil then
				game.speed = button_speed
				for index, player in pairs(game.players) do
					player.print("Game speed: " .. button_speed)
				end
			end
			ButtonsView.detect_speed_color_red()
		end
		-- #endregion operation of speed buttons

		-- for index, player in pairs(game.players) do
			-- player.print("Player index: " .. event.player_index)
		-- end

		-- if event.element.name == "timedec" then
			-- local ind_ex = game.player.index

			-- if global.button_count-1 >= 2 then 
				-- for i=1, global.button_count, 1 do
					-- local row_no = i+1
					-- global.button_caption[i] = player.gui.top.menu_tb["row_" .. row_no]["text_menu_0_" .. i].text
					-- if tonumber(player.gui.top.menu_tb["row_" .. row_no]["text_menu_1_" .. i].text) ~= nil then
						-- global.button_speed[i] = tonumber(player.gui.top.menu_tb["row_" .. row_no]["text_menu_1_" .. i].text)
					-- end
				-- end
				-- global.button_count = global.button_count - 1
				-- global.refreshmenu = true
				-- table.remove(global.button_speed, #global.button_speed)
				-- table.remove(global.button_caption, #global.button_caption)

			-- else
			-- player.print("The minimum number of speed buttons is 2")
			-- end
		-- end

		-- if event.element.name == "timeinc" then
			-- local ind_ex = game.player.index

			-- if global.button_count+1 <=10 then 
				-- for i=1, global.button_count, 1 do
					-- local row_no = i+1
					-- global.button_caption[i] = player.gui.top.menu_tb["row_" .. row_no]["text_menu_0_" .. i].text
					-- if tonumber(player.gui.top.menu_tb["row_" .. row_no]["text_menu_1_" .. i].text) ~= nil then
						-- global.button_speed[i] = tonumber(player.gui.top.menu_tb["row_" .. row_no]["text_menu_1_" .. i].text)
					-- end
				-- end
				-- global.button_count = global.button_count + 1
				-- global.refreshmenu = true
				-- global.button_caption[#global.button_caption+1] = "x1"
				-- global.button_speed[#global.button_speed+1] = 1

			-- else
				-- player.print("Limit the number of speed buttons reached")
			-- end
		-- end

		local player = game.get_player(event.player_index)

		if     event.element.name == "settingsbutton" 		then this.settingsbutton_onClick(player)
		elseif event.element.name == "settingsbutton_2" 	then this.settingsbutton_2_onClick()
		elseif event.element.name == "time_button_menu_end" then this.time_button_menu_end_onClick(player)
		elseif event.element.name == "timeinc" 				then this.timeinc_onClick(player)
		elseif event.element.name == "timedec" 				then this.timedec_onClick(player)
		end
	end,

	settingsbutton_onClick = function (player)
		ButtonsView.deleteAllForPlayer(player)
		SettingsView.drawSpeedMenuForPlayer(player)
	end,

	settingsbutton_2_onClick = function (player)
		if player.gui.top.menu_tb ==nil then return end
		if player.gui.top.menu_tb_2 == nil then
			Settings2View.drawSpeedMenu2ForPlayer(player)
		else
			if player.gui.top.menu_tb_2.row_0.min_speed.text == "" then player.gui.top.menu_tb_2.row_0.min_speed.text = 0 end
			global.min_time_tmp = tonumber(player.gui.top.menu_tb_2.row_0.min_speed.text)
			Settings2View.deleteSpeedMenu2ForPlayer(player)
		end
	end,

	time_button_menu_end_onClick = function(player)
		if player.gui.top.menu_tb==nil then return end

		for i=1, global.button_count, 1 do
			local row_n = i+1
			if tonumber(player.gui.top.menu_tb["row_" .. row_n]["text_menu_1_" .. i].text) ~= nil then
				if tonumber(player.gui.top.menu_tb["row_" .. row_n]["text_menu_1_" .. i].text) < 0.01 then
					player.print("Minimum speed value is 0.01", Colors.white)
					return
				end
			end
		end

		for i=1, global.button_count, 1 do
			local row_no = i+1
			global.button_caption[i] = player.gui.top.menu_tb["row_" .. row_no]["text_menu_0_" .. i].text
			if tonumber(player.gui.top.menu_tb["row_" .. row_no]["text_menu_1_" .. i].text) ~= nil then
				global.button_speed[i] = tonumber(player.gui.top.menu_tb["row_" .. row_no]["text_menu_1_" .. i].text)
			end
		end

		if tonumber(player.gui.top.menu_tb.row_0.text_noofbuttons.text) ~= nil then				
			global.button_count = tonumber(player.gui.top.menu_tb.row_0.text_noofbuttons.text)
		end

		if tonumber(player.gui.top.menu_tb.row_preend2.tbtfield1.text) ~= nil then				
			global.speedatcrafting = tonumber(player.gui.top.menu_tb.row_preend2.tbtfield1.text)
		end

		if player.gui.top.menu_tb.row_preend1.CheckBoxtb_row_preend2.state == false then global.chspeedoncraftingonoff = false
		elseif player.gui.top.menu_tb.row_preend1.CheckBoxtb_row_preend2.state == true then global.chspeedoncraftingonoff = true
		end

		if player.gui.top.menu_tb.row_preend1b.CheckBoxtb_row_preend1b.state == false then global.chspeedonminingonoff = false
		elseif player.gui.top.menu_tb.row_preend1b.CheckBoxtb_row_preend1b.state == true then global.chspeedonminingonoff = true
		end

		if player.gui.top.menu_tb.row_preend0.CheckBoxtb_row_preend0.state == false then
			global.show_timer = 0
			TimeView.deleteSpeedMenu()
		elseif player.gui.top.menu_tb.row_preend0.CheckBoxtb_row_preend0.state == true then
			global.show_timer = 1
			TimeView.addSpeedMenu()
		end

		if player.gui.top.menu_tb_2 ~= nil then
			if type(player.gui.top.menu_tb_2.row_0.min_speed.text) ~= "number" then
				player.gui.top.menu_tb_2.row_0.min_speed.text=0
				player.gui.top.menu_tb_2.row_0.min_speed.caption=0
			end
			global.min_time = tonumber(player.gui.top.menu_tb_2.row_0.min_speed.text)
			global.min_time_tmp = global.min_time
		else
			if type(global.min_time_tmp) ~= "number" then
				global.min_time_tmp = 0
			end
			global.min_time = global.min_time_tmp
		end

		player.gui.top.menu_tb.destroy()
		Settings2View.deleteSpeedMenu2ForPlayer(player)

		ButtonsView.deleteAll()
		ButtonsView.addButtons()
	end,

	timeinc_onClick = function (player)
		if global.button_count+1 > 10 then
			player.print("Limit the number of speed buttons reached", Colors.white)
			return
		end

		for i=1, global.button_count, 1 do
			local row_no = i+1
			global.button_caption[i] = player.gui.top.menu_tb["row_" .. row_no]["text_menu_0_" .. i].text
			if tonumber(player.gui.top.menu_tb["row_" .. row_no]["text_menu_1_" .. i].text) ~= nil then
				global.button_speed[i] = tonumber(player.gui.top.menu_tb["row_" .. row_no]["text_menu_1_" .. i].text)
			end
		end
		global.button_count = global.button_count + 1
	--	global.refreshmenu = true
		global.button_caption[#global.button_caption+1] = "x1"
		global.button_speed[#global.button_speed+1] = 1
		player.gui.top.menu_tb.destroy()
		SettingsView.drawSpeedMenuForPlayer(player)

		if debug_timebuttons == 1 then player.print("global.button_count " .. global.button_count .. " " .. #global.button_caption .. "" .. #global.button_speed, Colors.debug_color) end

		if debug_timebuttons == 1 then
			for i=1, global.button_count, 1 do
				player.print("global.button_caption " .. global.button_caption[i], Colors.debug_color)
			end
			for i=1, global.button_count, 1 do
				player.print("global.button_speed " .. global.button_speed[i], Colors.debug_color)
			end
		end
	end,

	timedec_onClick = function (player)
		if global.button_count-1 >= 2 then 
			for i=1, global.button_count, 1 do
				local row_no = i+1
				global.button_caption[i] = player.gui.top.menu_tb["row_" .. row_no]["text_menu_0_" .. i].text
				if tonumber(player.gui.top.menu_tb["row_" .. row_no]["text_menu_1_" .. i].text) ~= nil then
					global.button_speed[i] = tonumber(player.gui.top.menu_tb["row_" .. row_no]["text_menu_1_" .. i].text)
				end
			end
			global.button_count = global.button_count - 1
			--global.refreshmenu = true
			table.remove(global.button_speed, #global.button_speed)
			table.remove(global.button_caption, #global.button_caption)
				player.gui.top.menu_tb.destroy()
				SettingsView.drawSpeedMenuForPlayer(player)
		else
			player.print("The minimum number of speed buttons is 2")
		end
	end,

	on_tick = function(event)
		try(function() -- quick and dirty: catch the exception
			this.auto_ch_speed_when()
		end, function(e)
			--log
		end)

		--[[
		if game.tick%120==0 then
				for _, player in pairs(game.players) do
					if player.connected then
						for name, version in pairs(game.active_mods) do
						player.print(name .. " version " .. version)
						end
					end
				end
		end
		]]

		if game.tick%10 ~= 0 then return end
		if global.show_timer ~= 1 then return end

		local day_time = game.tick / 25000
		local dd1=day_time
		local dd2=math.floor(day_time)

		day_time = (day_time*24+12) % 24
		local day_time_h = math.floor(day_time)
		local day_time_m = math.floor((day_time-day_time_h)*60)

		local day_time_m_str = ""
		local day_time_h_str = ""
		if day_time_m < 10 then
			day_time_m_str = "0" .. day_time_m
		else
			day_time_m_str = day_time_m
		end
		if day_time_h < 10 then
			day_time_h_str= "0" .. day_time_h
		else
			day_time_h_str= day_time_h
		end

		for _, player in pairs(game.players) do
			if player.gui.top.time_frame ~= nil then
				player.gui.top.time_frame.timeplace.caption =" " .. day_time_h_str .. ":" .. day_time_m_str
			end
		end
	end,

	auto_ch_speed_when = function()
		if global.chspeedoncraftingonoff ~= true and global.chspeedonminingonoff ~= true then return end
		if game.tick%5~=0 then return end

		local speedatbegin = global.speedatcrafting
		for index, player in pairs(game.players) do
			if (player.crafting_queue_size > 0 and global.chspeedoncraftingonoff == true) or (player.mining_state.mining  == true and global.chspeedonminingonoff == true)  then
				if global.timer_1 ~= 0 then global.timer_1 = 0 end
				if global.speedatstartcrafting == 0 then
					global.speedatstartcrafting = game.speed
					game.speed = speedatbegin
					ButtonsView.detect_speed_color_red()
				end
			elseif (player.crafting_queue_size == 0 or player.mining_state.mining  == false) then
				if global.timer_1 == 0 then global.timer_1 = game.tick end
				if math.floor(game.tick - global.timer_1) >= global.min_time then
					if game.speed == speedatbegin and global.speedatstartcrafting ~= 0 then
						game.speed = global.speedatstartcrafting
						ButtonsView.detect_speed_color_red()
					end
					if global.speedatstartcrafting ~= 0 then global.speedatstartcrafting = 0 end
					if global.timer_1 ~= 0 then global.timer_1 = 0 end
				end
			end
		end
	end
}
this = control

script.on_init                                   (	control.on_init)
script.on_configuration_changed                  (	control.on_configuration_changed)
script.on_event(defines.events.on_player_created,	control.on_player_created)
script.on_event(defines.events.on_gui_click,		control.on_gui_click)
script.on_event(defines.events.on_tick,				control.on_tick)
script.on_event("speed_1"  , 						GameSpeed.game_speed_reset)
script.on_event("speed_inc", 						GameSpeed.game_speed_inc)
script.on_event("speed_dec", 						GameSpeed.game_speed_dec)
