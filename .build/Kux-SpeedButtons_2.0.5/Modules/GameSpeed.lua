GameSpeed = {}

function GameSpeed.game_speed_reset()
	game.speed = 1

	for index, player in pairs(game.players) do
		player.print("Game speed: 1")
	end
	ButtonsView.detect_speed_color_red()
end

function GameSpeed.game_speed_reset()
	game.speed = 1

	for index, player in pairs(game.players) do
		player.print("Game speed: 1")
	end
	ButtonsView.detect_speed_color_red()
end

function GameSpeed.game_speed_inc() 
	if game.speed < global.max_speed then
		game.speed = game.speed *2
	end

	ButtonsView.detect_speed_color_red()
end

function GameSpeed.game_speed_dec()
	if game.speed > global.min_speed then
		game.speed = game.speed /2
	end

	ButtonsView.detect_speed_color_red()
end