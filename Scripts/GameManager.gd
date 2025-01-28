extends Node

var Players = []
var current_turn = 0
var images = []
var questionChar = ["key", 0]
var answer = ""
var isTurn = false

func _ready():
	images = [
		preload("res://Assets/Characters/baldy.png"),
		preload("res://Assets/Characters/bandage.png")
	]

@rpc("any_peer")
func start_game():
	current_turn = 1
	for player in Players:
		player['image'] = images.pick_random()
	advance_turn.rpc_id(current_turn)
	Players[current_turn]['playerRef'].get_node("MeshInstance3D/Boy/Camera3D/FirstPersonHud/Turn").visible = true;
	#Players[0]['playerRef'].isTurn = false
	#Players[1]['playerRef'].isTurn = true

func add_player(name, id):
	if Players.size() < 2:
		var player_data = {"name": name, "id": id}
		Players.append(player_data)

	else:
		print("No more slots available for players.")

# Need to add guess part of variable
func player_guess(player_id: int, image: String):
	if Players[current_turn]['id'] == player_id:
		for player in Players:
			if player['id'] != player_id:
				if player['image'].load_path == image:
					end_game(player_id, player['id'])
				else:
					end_game(player['id'], player_id)

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

func end_game(winner_id: int, loser_id: int):
	print(get_player_by_id(winner_id)['name'] + " is the winner and " + get_player_by_id(loser_id)['name'] + " loses.")
	pass

func get_player_by_id(player_id):
	for player in Players:
		if player.id == player_id:
			return player
	return null
