extends Node3D

@onready var camera = $Camera3D as Camera3D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$MultiplayerSynchronizer.set_multiplayer_authority(str(name).to_int())
	if $MultiplayerSynchronizer.get_multiplayer_authority() == multiplayer.get_unique_id():
		camera.make_current()
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

# if $MultiplayerSynchronizer.get_multiplayer_authority() == multiplayer.get_unique_id()
# -- if true, following code will occur
