

white = {r = 1, g = 1, b = 1}
red = {r = 1, g = 0, b = 0} 
green = {r = 0, g = 1, b = 0}
yellow = {r = 1, g = 1, b = 0}
lightblue = {r = 0, g = 0.749, b = 1}	--rgb(0,191,255)
init = 0
debug_timebuttons = 0
debug_color = lightblue


script.on_init(function()
	init_all()
	
	delete_all()
	delete_time_menu()
	add_time_menu()
	add_buttons()
	
	if debug_timebuttons == 1 then
		for _, player in pairs(game.players) do
			if player.connected then
				player.print("on_init ", debug_color)
			end
		end
	end
	
 end)

script.on_configuration_changed (function()

init_all()

	delete_all()
	delete_time_menu()
	add_time_menu()
	add_buttons()

	if debug_timebuttons == 1 then
		for _, player in pairs(game.players) do
			if player.connected then
				player.print("on_configuration_changed ", debug_color)
			end
		end
	end

end)

script.on_event(defines.events.on_player_created, function(event)

	if debug_timebuttons == 1 then
		for _, player in pairs(game.players) do
			if player.connected then
				player.print("START on_player_created", debug_color)
			end
		end
	end

	
	delete_all()
	delete_time_menu()
	add_time_menu()
	add_buttons()
	
	if debug_timebuttons == 1 then
		for _, player in pairs(game.players) do
			if player.connected then
				player.print("END on_player_created", debug_color)
			end
		end
	end
	
end)

script.on_event(defines.events.on_gui_click, function(event)
     -- handle on gui click
	 --game.player.print(event.element.name)

		-- #region operation of speed buttons
		
		local x1,y1
		x1, y1 = string.find(event.element.name, "timebutton")
		if x1 ~= nil then
			local button_no = tonumber(string.sub(event.element.name, y1+1))      -- from character 7 until the end
			local button_speed = global.button_speed[button_no]
			if button_speed ~= nil then
				game.speed = button_speed
				for index, player in pairs(game.players) do
					player.print("Game speed: " .. button_speed)
				end
			end
			detect_speed_color_red()
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
					-- global.button_caption[i] = game.players[ind_ex].gui.top.menu_tb["row_" .. row_no]["text_menu_0_" .. i].text
					-- if tonumber(game.players[ind_ex].gui.top.menu_tb["row_" .. row_no]["text_menu_1_" .. i].text) ~= nil then
						-- global.button_speed[i] = tonumber(game.players[ind_ex].gui.top.menu_tb["row_" .. row_no]["text_menu_1_" .. i].text)
					-- end
				-- end
				-- global.button_count = global.button_count - 1
				-- global.refreshmenu = true
				-- table.remove(global.button_speed, #global.button_speed)
				-- table.remove(global.button_caption, #global.button_caption)

			-- else
			-- game.players[ind_ex].print("The minimum number of time buttons is 2")
			-- end
		-- end
		
		-- if event.element.name == "timeinc" then
			-- local ind_ex = game.player.index
			
			-- if global.button_count+1 <=10 then 
				-- for i=1, global.button_count, 1 do
					-- local row_no = i+1
					-- global.button_caption[i] = game.players[ind_ex].gui.top.menu_tb["row_" .. row_no]["text_menu_0_" .. i].text
					-- if tonumber(game.players[ind_ex].gui.top.menu_tb["row_" .. row_no]["text_menu_1_" .. i].text) ~= nil then
						-- global.button_speed[i] = tonumber(game.players[ind_ex].gui.top.menu_tb["row_" .. row_no]["text_menu_1_" .. i].text)
					-- end
				-- end
				-- global.button_count = global.button_count + 1
				-- global.refreshmenu = true
				-- global.button_caption[#global.button_caption+1] = "x1"
				-- global.button_speed[#global.button_speed+1] = 1

			-- else
				-- game.players[ind_ex].print("Limit the number of time buttons reached")
			-- end
		-- end
	
		if event.element.name == "settingsbutton" then
		
			delete_all_no(event.player_index)
			draw_time_menu_no(event.player_index)
			
		elseif event.element.name == "settingsbutton_2" then
			ind_ex = event.player_index
			
			if game.players[ind_ex].gui.top.menu_tb ~=nil then
				if game.players[ind_ex].gui.top.menu_tb_2 == nil then
					draw_time_menu_2_no(ind_ex)
				else
					if game.players[ind_ex].gui.top.menu_tb_2.row_0.min_speed.text == "" then game.players[ind_ex].gui.top.menu_tb_2.row_0.min_speed.text=0 end
					global.min_time_tmp=tonumber(game.players[ind_ex].gui.top.menu_tb_2.row_0.min_speed.text)
					delete_time_menu_2_no(ind_ex)
				end
			end
			
		elseif event.element.name == "time_button_menu_end" then
			
			ind_ex = event.player_index
			
			if game.players[ind_ex].gui.top.menu_tb~=nil then
			
				for i=1, global.button_count, 1 do
					local row_n = i+1
					if tonumber(game.players[ind_ex].gui.top.menu_tb["row_" .. row_n]["text_menu_1_" .. i].text) ~= nil then
						if tonumber(game.players[ind_ex].gui.top.menu_tb["row_" .. row_n]["text_menu_1_" .. i].text) < 0.01 then
							game.players[ind_ex].print("Minimum speed value is 0.01", white)
							goto goto_jump_1
						end
					end
				end
				
				
				for i=1, global.button_count, 1 do
					local row_no = i+1
					global.button_caption[i] = game.players[ind_ex].gui.top.menu_tb["row_" .. row_no]["text_menu_0_" .. i].text
					if tonumber(game.players[ind_ex].gui.top.menu_tb["row_" .. row_no]["text_menu_1_" .. i].text) ~= nil then
						global.button_speed[i] = tonumber(game.players[ind_ex].gui.top.menu_tb["row_" .. row_no]["text_menu_1_" .. i].text)
					end
				end
				

				if tonumber(game.players[ind_ex].gui.top.menu_tb.row_0.text_noofbuttons.text) ~= nil then				
					global.button_count = tonumber(game.players[ind_ex].gui.top.menu_tb.row_0.text_noofbuttons.text)
				end
				
				if tonumber(game.players[ind_ex].gui.top.menu_tb.row_preend2.tbtfield1.text) ~= nil then				
					global.speedatcrafting = tonumber(game.players[ind_ex].gui.top.menu_tb.row_preend2.tbtfield1.text)
				end
				
				if game.players[ind_ex].gui.top.menu_tb.row_preend1.CheckBoxtb_row_preend2.state == false then global.chspeedoncraftingonoff = false
				elseif game.players[ind_ex].gui.top.menu_tb.row_preend1.CheckBoxtb_row_preend2.state == true then global.chspeedoncraftingonoff = true
				end
				
				if game.players[ind_ex].gui.top.menu_tb.row_preend1b.CheckBoxtb_row_preend1b.state == false then global.chspeedonminingonoff = false
				elseif game.players[ind_ex].gui.top.menu_tb.row_preend1b.CheckBoxtb_row_preend1b.state == true then global.chspeedonminingonoff = true
				end
				
				
				if game.players[ind_ex].gui.top.menu_tb.row_preend0.CheckBoxtb_row_preend0.state == false then
					global.show_timer = 0
					delete_time_menu()
				elseif game.players[ind_ex].gui.top.menu_tb.row_preend0.CheckBoxtb_row_preend0.state == true then
					global.show_timer = 1
					add_time_menu()
				end
					

				if game.players[ind_ex].gui.top.menu_tb_2 ~= nil then
					if type(game.players[ind_ex].gui.top.menu_tb_2.row_0.min_speed.text) ~= "number" then
						game.players[ind_ex].gui.top.menu_tb_2.row_0.min_speed.text=0
						game.players[ind_ex].gui.top.menu_tb_2.row_0.min_speed.caption=0
					end
					global.min_time=tonumber(game.players[ind_ex].gui.top.menu_tb_2.row_0.min_speed.text)
					global.min_time_tmp=global.min_time
				else
					if type(global.min_time_tmp) ~= "number" then
						global.min_time_tmp=0
					end
					global.min_time=global.min_time_tmp
				end
					
				game.players[ind_ex].gui.top.menu_tb.destroy()
				delete_time_menu_2_no(ind_ex)
				
				delete_all()
				add_buttons()

			end
			::goto_jump_1::
			
		elseif event.element.name == "timeinc" then
			local ind_ex = event.player_index
						
			if global.button_count+1 <=10 then 
				for i=1, global.button_count, 1 do
					local row_no = i+1
					global.button_caption[i] = game.players[ind_ex].gui.top.menu_tb["row_" .. row_no]["text_menu_0_" .. i].text
					if tonumber(game.players[ind_ex].gui.top.menu_tb["row_" .. row_no]["text_menu_1_" .. i].text) ~= nil then
						global.button_speed[i] = tonumber(game.players[ind_ex].gui.top.menu_tb["row_" .. row_no]["text_menu_1_" .. i].text)
					end
				end
				global.button_count = global.button_count + 1
			--	global.refreshmenu = true
				global.button_caption[#global.button_caption+1] = "x1"
				global.button_speed[#global.button_speed+1] = 1
					game.players[ind_ex].gui.top.menu_tb.destroy()
					draw_time_menu_no(event.player_index)

					if debug_timebuttons == 1 then game.players[ind_ex].print("global.button_count " .. global.button_count .. " " .. #global.button_caption .. "" .. #global.button_speed, debug_color) end
					
					if debug_timebuttons == 1 then
						for i=1, global.button_count, 1 do
							game.players[ind_ex].print("global.button_caption " .. global.button_caption[i], debug_color)
						end
						for i=1, global.button_count, 1 do
							game.players[ind_ex].print("global.button_speed " .. global.button_speed[i], debug_color)
						end
					end
					
			else
				game.players[ind_ex].print("Limit the number of time buttons reached",white)
			end
			
		elseif event.element.name == "timedec" then
			local ind_ex = event.player_index
		
			if global.button_count-1 >= 2 then 
				for i=1, global.button_count, 1 do
					local row_no = i+1
					global.button_caption[i] = game.players[ind_ex].gui.top.menu_tb["row_" .. row_no]["text_menu_0_" .. i].text
					if tonumber(game.players[ind_ex].gui.top.menu_tb["row_" .. row_no]["text_menu_1_" .. i].text) ~= nil then
						global.button_speed[i] = tonumber(game.players[ind_ex].gui.top.menu_tb["row_" .. row_no]["text_menu_1_" .. i].text)
					end
				end
				global.button_count = global.button_count - 1
				--global.refreshmenu = true
				table.remove(global.button_speed, #global.button_speed)
				table.remove(global.button_caption, #global.button_caption)
					game.players[ind_ex].gui.top.menu_tb.destroy()
					draw_time_menu_no(event.player_index)
			else
			game.players[ind_ex].print("The minimum number of time buttons is 2")
			end
		end
		
		
		

end)

script.on_event(defines.events.on_tick, function(event)

try(function() -- quick and dirty: catch the exception
	auto_ch_speed_when()
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

if game.tick%10==0 then

	if global.show_timer == 1 then
		
		day_time=game.tick / 25000
		dd1=day_time
		dd2=math.floor(day_time)
		
		day_time = (day_time*24+12) % 24
		day_time_h = math.floor(day_time)
		day_time_m = math.floor((day_time-day_time_h)*60)
		
		day_time_m_str = ""
		if day_time_m<10 then
			day_time_m_str= "0" .. day_time_m
		else
			day_time_m_str= day_time_m
		end
		if day_time_h<10 then
			day_time_h_str= "0" .. day_time_h
		else
			day_time_h_str= day_time_h
		end
		
		for index, player in pairs(game.players) do
			if player.gui.top.time_frame ~= nil then
				player.gui.top.time_frame.timeplace.caption =" " .. day_time_h_str .. ":" .. day_time_m_str
			end
		end	
	
	end	
end


end)

function init_all()
	
	if global.button_count == nil then
		global.button_count = 5
	end	
	
	if global.button_caption == nil then
		global.button_caption = {"x0.5", "x1", "x2", "x3", "x5"}
	end	
	
	if global.button_speed == nil then
		global.button_speed = {0.5, 1, 2 ,3 ,5}
	end	

	if global.button_menu_timer == nil then
		global.button_menu_timer = 0
	end
	
	if global.chspeedoncraftingonoff == nil then
		global.chspeedoncraftingonoff = false
	end
	
	if global.chspeedonminingonoff == nil then
		global.chspeedonminingonoff = false
	end
		
		
	if global.speedatcrafting == nil then
		global.speedatcrafting = 2
	end
	
	if global.speedatstartcrafting == nil then
		global.speedatstartcrafting = 0
	end
	
	-- if global.timebuttons_compatibility == nil then
		-- global.timebuttons_compatibility = {false,false}
	-- end
	
	if global.show_timer == nil then
		global.show_timer = 1
	end

	if global.min_time == nil then
		global.min_time = 60	--in game ticks... 60ticks= 1 second
	end
	
	if global.timer_1 == nil then
		global.timer_1 = 0	--in game ticks... 60ticks= 1 second
	end
 
 	if global.min_time_tmp == nil then
		for name, version in pairs(game.active_mods) do
			if name == "TimeButtons" then
				if version == "0.3.5" then
					global.min_time = 20
				end
			end
		end
	
		global.min_time_tmp = global.min_time	--in game ticks... 60ticks= 1 second
	end
 
 	if global.max_speed == nil or global.max_speed ~= 256 then
		global.max_speed = 256
	end
 
  	if global.min_speed == nil or global.min_speed ~= 0.125 then
		global.min_speed = 0.125
	end
 
end

function delete_all()

	for index, player in pairs(game.players) do
		if player.gui.top.tb_frame ~= nil then player.gui.top.tb_frame.destroy() end
		if debug_timebuttons == 1 then player.print("delete_all  player: " .. index, debug_color) end
	end

end

function delete_all_no(no)

	if game.players[no].gui.top.tb_frame ~= nil then game.players[no].gui.top.tb_frame.destroy() end
	--game.players[no].print("Delete ALL")

end

function add_buttons()

--add_time_menu()

for index, player in pairs(game.players) do

	if player.gui.top.tb_frame == nil then
		
		player.gui.top.add({type="frame", name="tb_frame", caption="",direction="horizontal", style="tbgui"}) --, style="tbgui"  
	
		for i=1, global.button_count, 1 do
			if player.gui.top.tb_frame ~= nil then
				player.gui.top.tb_frame.add({type = "button", name="timebutton" .. i, caption=global.button_caption[i], fontcolor = white, style="time_button"})
			end
		end

		player.gui.top.tb_frame.add({type = "button", name="settingsbutton", caption="", fontcolor = white, style="time_button_s"})
		
		
		
		player.gui.top.tb_frame.add{type="label", name="cur_speed", caption=" "}
		player.gui.top.tb_frame.cur_speed.style.font="default-large-bold"
		player.gui.top.tb_frame.cur_speed.style.font_color = {r = 1, g = 1, b = 1}
		--player.gui.top.tb_frame.style.minimal_width = 80
	
		detect_speed_color_red()
		
	end
	
	if debug_timebuttons == 1 then player.print("add_buttons  player: " .. index, debug_color) end
	
end

	
end

function add_buttons_no(no)


	if game.players[no].gui.top.tb_frame == nil then
	
		game.players[no].gui.top.add({type="frame", name="tb_frame", caption="",direction="horizontal", style="tbgui"}) --, style="tbgui" , style="tbgui"
	
		for i=1, global.button_count, 1 do
			if game.players[no].gui.top.tb_frame ~= nil then
				
				game.players[no].gui.top.tb_frame.add({type = "button", name="timebutton" .. i, caption=global.button_caption[i], fontcolor = white, style="time_button"})
				
			end
		end
		
		game.players[no].gui.top.tb_frame.add({type = "button", name="settingsbutton", caption="", fontcolor = white, style="time_button_s"})
		
		detect_speed_color_red()
	end
	


	
end

function all_yellow()
for index, player in pairs(game.players) do	
	for i=1, global.button_count, 1 do
		if player.gui.top.tb_frame ~= nil then
			player.gui.top.tb_frame["timebutton" .. i].style.font_color = yellow
			player.gui.top.tb_frame.cur_speed.caption = " x" .. game.speed
			speed_detected = true
		end
	end
	player.print("Game speed : " .. game.speed)
	

end	
end

function all_white()
for index, player in pairs(game.players) do
	for i=1, global.button_count, 1 do
		if player.gui.top.tb_frame ~= nil then
			--player.print("i=" .. i)
			player.gui.top.tb_frame["timebutton" .. i].style.font_color = white
			speed_detected = true
		end
	end
end
end

function detect_speed_color_red()
local speed_detected = false
	
	all_white()

for index, player in pairs(game.players) do
	for i=1, global.button_count, 1 do
		if game.speed == global.button_speed[i] then
			if player.gui.top.tb_frame ~= nil then
				player.gui.top.tb_frame["timebutton" .. i].style.font_color = red
				--player.gui.top.tb_frame.cur_speed.caption = " "
				speed_detected = true
			end
		end
	end
end
	
	
for index, player in pairs(game.players) do	
	if player.gui.top.tb_frame ~= nil then
		player.gui.top.tb_frame.cur_speed.caption = " "
	end	
end
	
	if speed_detected == false then
		all_yellow()
	end
	
end

function draw_time_menu()
	for index, player in pairs(game.players) do
			--player.print("Draw Time Menu")
			if player.gui.top.menu_tb == nil then
			
				player.gui.top.add({type="frame", name="menu_tb", caption="            Time Buttons Menu",direction="vertical"})
				--game.player.gui.top.menu_tb.style.align = "center"
				
				player.gui.top.menu_tb.add({type="flow",name="row_0",direction="horizontal"})
				player.gui.top.menu_tb.row_0.add({type="label", name="label_menu_0", caption="Number of time buttons:"})
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
					mw=315
					player.gui.top.menu_tb.row_end.time_button_menu_end.style.maximal_width=mw
					player.gui.top.menu_tb.row_end.time_button_menu_end.style.minimal_width=mw	
				
				
					
			end
			
	end		
end

function draw_time_menu_no(no)
	
			--game.players[no].print("Draw Time Menu")
			if game.players[no].gui.top.menu_tb == nil then
			
				game.players[no].gui.top.add({type="frame", name="menu_tb", caption="",direction="vertical"}) --            Time Buttons Menu
				
				game.players[no].gui.top.menu_tb.add({type="flow",name="row_title",direction="horizontal"})
				game.players[no].gui.top.menu_tb.row_title.add({type="label", name="label_menu_title", caption="            Time Buttons Menu     "})
					game.players[no].gui.top.menu_tb.row_title.label_menu_title.style.font="bt_menu_font"
				game.players[no].gui.top.menu_tb.row_title.add({type = "button", name="settingsbutton_2", caption="", fontcolor = white, style="time_button_s"})
				
				game.players[no].gui.top.menu_tb.add({type="flow",name="row_0",direction="horizontal"})
				game.players[no].gui.top.menu_tb.row_0.add({type="label", name="label_menu_0", caption="Number of time buttons:"})
				game.players[no].gui.top.menu_tb.row_0.add({type="textfield", name="text_noofbuttons", caption="", style="tb_textfield_style"})
					game.players[no].gui.top.menu_tb.row_0.text_noofbuttons.caption = global.button_count
				game.players[no].gui.top.menu_tb.row_0.add({type="button", name="timedec", caption="", style="time_button_dec"})
				game.players[no].gui.top.menu_tb.row_0.add({type="button", name="timeinc", caption="", style="time_button_inc"})
				
				game.players[no].gui.top.menu_tb.add({type="flow",name="row_1",direction="horizontal"})
				game.players[no].gui.top.menu_tb.row_1.add({type="label", name="label_menu_0", caption=" "})
				game.players[no].gui.top.menu_tb.row_1.add({type="label", name="label_menu_1", caption="Name"})
				game.players[no].gui.top.menu_tb.row_1.add({type="label", name="label_menu_4", caption=" "})
				game.players[no].gui.top.menu_tb.row_1.add({type="label", name="label_menu_2", caption="Speed"})
				--game.game.players[no].gui.top.menu_tb.row_1.add({type="label", name="label_menu_5", caption=" "})
			--	game.game.players[no].gui.top.menu_tb.row_1.add({type="label", name="label_menu_3", caption="ON/OFF"})
					game.players[no].gui.top.menu_tb.row_1.label_menu_1.style.font="default-bold"
					game.players[no].gui.top.menu_tb.row_1.label_menu_2.style.font="default-bold"
				--	game.game.players[no].gui.top.menu_tb.row_1.label_menu_3.style.font="default-bold"
					game.players[no].gui.top.menu_tb.row_1.label_menu_0.style.minimal_width=81
					game.players[no].gui.top.menu_tb.row_1.label_menu_1.style.minimal_width=40
					game.players[no].gui.top.menu_tb.row_1.label_menu_2.style.minimal_width=40
				--	game.game.players[no].gui.top.menu_tb.row_1.label_menu_3.style.minimal_width=40
					game.players[no].gui.top.menu_tb.row_1.label_menu_4.style.minimal_width=33
				--	game.game.players[no].gui.top.menu_tb.row_1.label_menu_5.style.minimal_width=21
		
				for i=1, global.button_count, 1 do
					local row_no = i+1
					game.players[no].gui.top.menu_tb.add({type="flow",name="row_" .. row_no,direction="horizontal"})
					game.players[no].gui.top.menu_tb["row_" .. row_no].add({type="label", name="label_menu_4", caption="Button " .. i .. ":"})
					game.players[no].gui.top.menu_tb["row_" .. row_no].add({type="textfield", name="text_menu_0_" .. i, caption="", style="tb_textfield_style"}) 
					game.players[no].gui.top.menu_tb["row_" .. row_no].add({type="textfield", name="text_menu_1_" .. i, caption="",style="tb_textfield_style"})
						game.players[no].gui.top.menu_tb["row_" .. row_no].label_menu_4.style.font="default-bold"
						local mw=80
						game.players[no].gui.top.menu_tb["row_" .. row_no]["text_menu_0_" .. i].style.maximal_width=mw
						game.players[no].gui.top.menu_tb["row_" .. row_no]["text_menu_1_" .. i].style.maximal_width=mw
						game.players[no].gui.top.menu_tb["row_" .. row_no]["text_menu_0_" .. i].style.minimal_width=mw
						game.players[no].gui.top.menu_tb["row_" .. row_no]["text_menu_1_" .. i].style.minimal_width=mw
						mw=34
						game.players[no].gui.top.menu_tb["row_" .. row_no]["text_menu_0_" .. i].style.minimal_height=mw
						game.players[no].gui.top.menu_tb["row_" .. row_no]["text_menu_1_" .. i].style.minimal_height=mw
						game.players[no].gui.top.menu_tb["row_" .. row_no]["text_menu_0_" .. i].caption = global.button_caption[i]
						game.players[no].gui.top.menu_tb["row_" .. row_no]["text_menu_1_" .. i].caption = global.button_speed[i]
						if global.button_caption[i] ~= nil then game.players[no].gui.top.menu_tb["row_" .. row_no]["text_menu_0_" .. i].text = global.button_caption[i] end
						if global.button_speed[i] ~= nil then game.players[no].gui.top.menu_tb["row_" .. row_no]["text_menu_1_" .. i].text = global.button_speed[i] end
					
				end
		
				game.players[no].gui.top.menu_tb.add({type="flow",name="row_preend0",direction="vertical"})
				game.players[no].gui.top.menu_tb.row_preend0.add({type="checkbox", name="CheckBoxtb_row_preend0", caption="Show/Hide Clock", state=false})
					if global.show_timer == 0 then game.players[no].gui.top.menu_tb.row_preend0.CheckBoxtb_row_preend0.state = false
					elseif global.show_timer == 1 then game.players[no].gui.top.menu_tb.row_preend0.CheckBoxtb_row_preend0.state = true
					end
		
				game.players[no].gui.top.menu_tb.add({type="flow",name="row_preend1",direction="horizontal"})
				game.players[no].gui.top.menu_tb.row_preend1.add({type="checkbox", name="CheckBoxtb_row_preend2", caption="Check me and when you start crafting", state=false})
					if global.chspeedoncraftingonoff == false then game.players[no].gui.top.menu_tb.row_preend1.CheckBoxtb_row_preend2.state = false
					elseif global.chspeedoncraftingonoff == true then game.players[no].gui.top.menu_tb.row_preend1.CheckBoxtb_row_preend2.state = true
					end
				
				game.players[no].gui.top.menu_tb.add({type="flow",name="row_preend1b",direction="horizontal"})
				game.players[no].gui.top.menu_tb.row_preend1b.add({type="checkbox", name="CheckBoxtb_row_preend1b", caption="Check me and when you start mining", state=false})
					if global.chspeedonminingonoff == false then game.players[no].gui.top.menu_tb.row_preend1b.CheckBoxtb_row_preend1b.state = false
					elseif global.chspeedonminingonoff == true then game.players[no].gui.top.menu_tb.row_preend1b.CheckBoxtb_row_preend1b.state = true
					end
				
				game.players[no].gui.top.menu_tb.add({type="flow",name="row_preend2",direction="horizontal"})
				game.players[no].gui.top.menu_tb.row_preend2.add({type="label", name="label_menu_10", caption="game speed will change to:"})				
				game.players[no].gui.top.menu_tb.row_preend2.add({type="textfield", name="tbtfield1", caption="", style="tb_textfield_style"})
				--game.players[no].gui.top.menu_tb.row_preend2.add({type="label", name="label_menu_11", caption="and after crafting is"})
					game.players[no].gui.top.menu_tb.row_preend2.tbtfield1.caption = global.speedatcrafting
					game.players[no].gui.top.menu_tb.row_preend2.tbtfield1.style.minimal_width=70
				
				game.players[no].gui.top.menu_tb.add({type="flow",name="row_preend2b",direction="vertical"})
				game.players[no].gui.top.menu_tb.row_preend2b.add({type="label", name="label_menu_11", caption="and after crafting is finished it will return"})
				
				game.players[no].gui.top.menu_tb.add({type="flow",name="row_preend3",direction="vertical"})
				game.players[no].gui.top.menu_tb.row_preend3.add({type="label", name="label_menu_12", caption="to previous value unless you change"})
				game.players[no].gui.top.menu_tb.row_preend3.add({type="label", name="label_menu_13", caption="game speed during crafting/mining."})
				
	

				--[[
				game.players[no].gui.top.menu_tb.add({type="flow",name="row_preend5",direction="horizontal"})
				game.players[no].gui.top.menu_tb.row_preend5.add({type="label", name="label_menu_14", caption="game speed... blah blah ...:"})				
				game.players[no].gui.top.menu_tb.row_preend5.add({type="textfield", name="tbtfield2", caption="", style="tb_textfield_style"})
					game.players[no].gui.top.menu_tb.row_preend5.tbtfield2.caption = global.speedatcrafting
					game.players[no].gui.top.menu_tb.row_preend5.tbtfield2.style.minimal_width=70
				]]--
				
				game.players[no].gui.top.menu_tb.add({type="flow",name="row_end",direction="horizontal"})
				game.players[no].gui.top.menu_tb.row_end.add({type="button", name="time_button_menu_end", caption="SAVE AND CLOSE", style="time_button"})
					game.players[no].gui.top.menu_tb.row_end.time_button_menu_end.style.font="default-bold"
					mw=245
					game.players[no].gui.top.menu_tb.row_end.time_button_menu_end.style.maximal_width=mw
					game.players[no].gui.top.menu_tb.row_end.time_button_menu_end.style.minimal_width=mw
				
			end
			
			
end

function draw_time_menu_2_no(no)
	
			if game.players[no].gui.top.menu_tb_2 == nil then
			
				game.players[no].gui.top.add({type="frame", name="menu_tb_2", caption="",direction="vertical"})
				
				game.players[no].gui.top.menu_tb_2.add({type="flow",name="row_title",direction="horizontal"})
				game.players[no].gui.top.menu_tb_2.row_title.add({type="label", name="label_menu_title", caption="          Time Buttons Sub Menu    "})
				
				game.players[no].gui.top.menu_tb_2.add({type="flow",name="row_0",direction="horizontal"})
				game.players[no].gui.top.menu_tb_2.row_0.add({type="label", name="label_menu_0", caption="min. speed change time:"})
				game.players[no].gui.top.menu_tb_2.row_0.add({type="textfield", name="min_speed", caption="", text="", style="tb_textfield_style"})
					
				if global.min_time_tmp ~= global.min_time then
					game.players[no].gui.top.menu_tb_2.row_0.min_speed.text=global.min_time_tmp
				else
					game.players[no].gui.top.menu_tb_2.row_0.min_speed.text=global.min_time
				end
					
				
				
				--min_time_tmp
				--global.min_time
				-- min. speed change time
				
			end
			
			
end

function auto_ch_speed_when()

	if global.chspeedoncraftingonoff == true or global.chspeedonminingonoff == true  then
		
		if game.tick%5==0 then
		local speedatbegin = global.speedatcrafting
			for index, player in pairs(game.players) do
				if (player.crafting_queue_size > 0 and global.chspeedoncraftingonoff == true) or (player.mining_state.mining  == true and global.chspeedonminingonoff == true)  then
					if global.timer_1 ~= 0 then global.timer_1 = 0 end
					if global.speedatstartcrafting == 0 then
						global.speedatstartcrafting = game.speed 
						game.speed = speedatbegin
						detect_speed_color_red()
					end
				elseif (player.crafting_queue_size == 0 or player.mining_state.mining  == false) then
					
					if global.timer_1 == 0 then global.timer_1 = game.tick end
					
					if math.floor(game.tick - global.timer_1) >= global.min_time then
					
						if game.speed == speedatbegin and global.speedatstartcrafting ~= 0 then
							game.speed = global.speedatstartcrafting
							detect_speed_color_red()
						end
						
						if global.speedatstartcrafting ~= 0 then global.speedatstartcrafting = 0 end
						if global.timer_1 ~= 0 then global.timer_1 = 0 end							
					end
				end
			end
		end
	end
end

function add_time_menu()

	for index, player in pairs(game.players) do	
		if player.gui.top.time_frame == nil and global.show_timer == 1 then
			player.gui.top.add({type="frame", name="time_frame", caption="",direction="vertical", style="tbgui"})--, style="tbgui"
			player.gui.top.time_frame.add{type="label", name="timeplace", caption=" "}
			player.gui.top.time_frame.timeplace.style.font="default-large-bold"
			player.gui.top.time_frame.timeplace.style.font_color = {r = 1, g = 1, b = 1}
			player.gui.top.time_frame.style.minimal_width = 80
			if debug_timebuttons == 1 then player.print("add_time_menu  player: " .. index, debug_color) end
		end
	end
	
end

function delete_time_menu() 

		for index, player in pairs(game.players) do
			if player.gui.top.time_frame ~= nil then player.gui.top.time_frame.destroy() end
			if debug_timebuttons == 1 then player.print("delete_time_menu  player: " .. index, debug_color) end
		end
	
end

function delete_time_menu_2() 

		for index, player in pairs(game.players) do
			if player.gui.top.menu_tb_2 ~= nil then player.gui.top.menu_tb_2.destroy() end
			if debug_timebuttons == 1 then player.print("delete_time_menu_2  player: " .. index, debug_color) end
		end
	
end

function delete_time_menu_2_no(no) 

	if game.players[no].gui.top.menu_tb_2 ~= nil then game.players[no].gui.top.menu_tb_2.destroy() end
	
end

function game_speed_reset() 
	game.speed = 1
				
	for index, player in pairs(game.players) do
		player.print("Game speed: 1")
	end
	detect_speed_color_red()
end

function game_speed_reset() 
	game.speed = 1
				
	for index, player in pairs(game.players) do
		player.print("Game speed: 1")
	end
	detect_speed_color_red()
end

function game_speed_inc() 
	if game.speed < global.max_speed then
		game.speed = game.speed *2
	end
				
	detect_speed_color_red()
end

function game_speed_dec() 
	if game.speed > global.min_speed then
		game.speed = game.speed /2
	end
				
	detect_speed_color_red()
end

function try(f, catch_f)
	local status, exception = pcall(f)
	if not status then
		catch_f(exception)
	end
end

script.on_event("speed_1", function(event) return game_speed_reset() end)
script.on_event("speed_inc", function(event) return game_speed_inc() end)
script.on_event("speed_dec", function(event) return game_speed_dec() end)
