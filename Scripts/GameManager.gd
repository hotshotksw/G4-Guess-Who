extends Node

var Players = []
var current_turn = 0
var images = []
var questionChar = [null, null]

func _ready():
	if images.size() != 0:
		return

	var dir = DirAccess.open("res://Assets/Characters/")

	if dir:
		dir.list_dir_begin()
		var file_name = dir.get_next()

		while file_name != "":
			images.append(load("res://Assets/Characters/" + file_name))
			file_name = dir.get_next()

		dir.list_dir_end()

@rpc("authority")
func start_game():
	if Players.size() < 2:
		print("Cannot start game. Add more players.")
		return

	for player in Players:
		var image = images.pick_random()
		player['image'] = image
		player['playerRef'].set_image(image)

	advance_turn()

func add_player(name, id):
	if Players.size() < 2:
		var player_data = {"name": name, "id": id, "image": null}
		Players.append(player_data)
	else:
		print("No more slots available for players.")

@rpc("authority")
func player_guess(player_id: int, image: String):
	if Players[current_turn]['id'] == player_id:
		for player in Players:
			if player['id'] != player_id:
				if player['image'].get_path() == image:
					rpc("end_game", player_id, player['id'])
				else:
					rpc("end_game", player['id'], player_id)

func ask_question(key, value):
	print(key)
	print(value)
	advance_turn()

@rpc("any_peer", "call_local")
func advance_turn():
	var currentPlayer = Players[current_turn]['playerRef']
	currentPlayer.get_node('MeshInstance3D/Boy/Camera3D/QuestionUi').visible = false

	current_turn = (current_turn + 1) % 2

	currentPlayer = Players[current_turn]['playerRef']
	currentPlayer.get_node('MeshInstance3D/Boy/Camera3D/QuestionUi').visible = true

@rpc("authority")
func end_game(winner_id: int, loser_id: int):
	var winner = get_player_by_id(winner_id)
	var loser = get_player_by_id(loser_id)

	winner['playerRef'].get_node('MeshInstance3D/Boy/Camera3D/EndScreen/Win').visible = true
	loser['playerRef'].get_node('MeshInstance3D/Boy/Camera3D/EndScreen/Lose').visible = true

func get_player_by_id(player_id):
	for player in Players:
		if player['id'] == player_id:
			return player
	return null
