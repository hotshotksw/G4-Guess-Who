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
			images.append(str("res://Assets/Characters/" + file_name))
			file_name = dir.get_next()

		dir.list_dir_end()

@rpc("authority")
func start_game():
	if Players.size() < 2:
		print("Cannot start game. Add more players.")
		return
		
	select_player_image()

	advance_turn()

func add_player(name, id):
	if Players.size() < 2:
		var player_data = {"name": name, "id": id}
		Players.append(player_data)
	else:
		print("No more slots available for players.")

@rpc("authority")
func player_guess(player_id: int, image: Image):
	if Players[current_turn]['id'] == player_id:
		for player in Players:
			if player['id'] != player_id:
				if player['image'] == image:
					end_game(player_id, player['id'])
				else:
					end_game(player['id'], player_id)

@rpc("any_peer","call_local")
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

@rpc("any_peer","reliable")
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

func select_player_image():
	var boards = get_tree().get_nodes_in_group("Board")
	var flippers = boards[0].get_children()
	var c : Flipper = flippers[randi() % flippers.size()]
	var image = c.image
	#var chars = c.characteristics
	#print(str(chars.Char_Gender) + " " + str(chars.Char_HairColor) + " " + str(chars.Char_EyeColor))
	#var image = images.pick_random()
	Players[0]['characteristics'] = c.characteristics
	Players[0]['image'] = image
	Players[0]['playerRef'].set_image(image)
