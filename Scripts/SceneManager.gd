extends Node3D

@export var PlayerScene : PackedScene

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var index = 0
	for player_data in GameManager.Players:
		var currentPlayer = PlayerScene.instantiate()
		currentPlayer.name = str(player_data.id)
		player_data['playerRef'] = currentPlayer
		add_child(currentPlayer)

		for spawn in get_tree().get_nodes_in_group("PlayerSpawnPoint"):
			if spawn.name == str(index):
				currentPlayer.global_position = spawn.global_position
				currentPlayer.global_rotation = spawn.global_rotation

		if index == 0:
			$Board_0.set_multiplayer_authority(player_data.id)

		elif index == 1:
			$Board_1.set_multiplayer_authority(player_data.id)

		index += 1

	GameManager.start_game()
