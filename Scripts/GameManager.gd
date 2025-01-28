extends Node

var Players = []
var current_turn = 0
var images = []
var questionChar = ["key", 0]
var answer = ""
var isTurn = false

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
	current_turn = 1
	select_player_image()
	advance_turn.rpc_id(current_turn)
	Players[current_turn]['playerRef'].get_node("MeshInstance3D/Boy/Camera3D/FirstPersonHud/Turn").visible = true;
	#Players[0]['playerRef'].isTurn = false
	#Players[1]['playerRef'].isTurn = true

@rpc("authority")
func add_player(name, id):
	if Players.size() < 2:
		var player_data = {"name": name, "id": id, "playerRef": null}
		Players.append(player_data)

	else:
		print("No more slots available for players.")

@rpc("authority")
func player_guess(player_id: int, image: Image):
	if Players[current_turn]['id'] != player_id:
		return

	for player in Players:
		if player['id'] != player_id:
			if player['playerRef'].path == image.resource_path:
				end_game(player_id, player['id'])

			else:
				end_game(player['id'], player_id)

@rpc("any_peer","call_local")
func ask_question(key, value):
	print(key)
	print(value)
	var placeholder = {"Gender":0}
	var result = "No"
	if(placeholder[key] == value):
		result = "yes"
	answer = result

@rpc("any_peer", "call_local")
func advance_turn():
	
	var currentPlayer = Players[current_turn]['playerRef']
	currentPlayer.get_node("MeshInstance3D/Boy/Camera3D/FirstPersonHud/Turn").text = "Not your turn"
	#currentPlayer.isTurn = false
	
	
	current_turn = (current_turn + 1) % 2

	currentPlayer = Players[current_turn]['playerRef']
	currentPlayer.get_node("MeshInstance3D/Boy/Camera3D/FirstPersonHud/Turn").text = "your turn"
	#currentPlayer.isTurn = true

	print("Current Turn: ", current_turn, " on ", multiplayer.get_unique_id())
	print("Players Data: ", str(Players))


@rpc("authority")
func end_game(winner_id: int, loser_id: int):
	var winner = get_player_by_id(winner_id)
	var loser = get_player_by_id(loser_id)

	if winner and loser:
		winner['playerRef'].rpc_id(winner_id, "set_win_screen")
		loser['playerRef'].rpc_id(loser_id, "set_lose_screen")

	else:
		print("Error: Winner or loser not found.")


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
