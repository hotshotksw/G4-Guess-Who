extends Node

var Players = []
var current_turn = 0
var images = []
var questionChar = [null, null]

func _ready():
	images = [
		preload("res://Assets/Characters/baldy.png"),
		preload("res://Assets/Characters/bandage.png")
	]

func start_game():
	current_turn = randi() % 2
	for player in Players:
		player['image'] = images.pick_random()

func add_player(name, id):
	if Players.size() < 2:
		var player_data = {"name": name, "id": id}
		Players.append(player_data)

	else:
		print("No more slots available for players.")

# Need to add guess part of variable
func player_guess(player_id):
	pass

func ask_question(key, value):
	print(key)
	print(value)
	advance_turn()
	pass

func advance_turn():
	current_turn = (current_turn + 1) % Players.size()

func end_game(winner_id):
	pass

func get_player_by_id(player_id):
	for player in Players:
		if player.id == player_id:
			return player
	return null
