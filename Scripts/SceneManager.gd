extends Node3D

@export var PlayerScene : PackedScene
@export var FlipperScene : PackedScene

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var index = 0
	for i in GameManager.Players:
		var currentPlayer = PlayerScene.instantiate()
		currentPlayer.name = str(GameManager.Players[i].id)
		add_child(currentPlayer)
		for spawn in get_tree().get_nodes_in_group("PlayerSpawnPoint"):
			if spawn.name == str(index):
				currentPlayer.global_position = spawn.global_position
				currentPlayer.global_rotation = spawn.global_rotation

		var flipper = FlipperScene.instantiate()
		add_child(flipper)
		flipper.global_position = currentPlayer.global_position - Vector3(0, 2, 0)
		flipper.global_position.x -= 5 * sign(currentPlayer.global_position.x)
		flipper.global_rotation = currentPlayer.global_rotation + Vector3(0, deg_to_rad(-90), 0)
		flipper.set_multiplayer_authority(GameManager.Players[i].id)

		index += 1


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
	#pass
