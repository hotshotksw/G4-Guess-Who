extends Node3D

@export var texture = preload("res://models/wpwh1qb3.jpg")
var open = true
@onready var anim_player = $AnimationPlayer
@onready var synchronizer = $MultiplayerSynchronizer
@onready var characteristics = $Flipper_Characteristics

var gue
#@export var stuff = Characteristics.new()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	gue = texture.load_path
	var image = texture.get_image()

	texture = ImageTexture.create_from_image(image)
	var mat = StandardMaterial3D.new()
	mat.albedo_texture = texture
	$Armature/Skeleton3D/Cylinder.set_surface_override_material(1, mat)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_area_3d_input_event(camera: Node, event: InputEvent, event_position: Vector3, normal: Vector3, shape_idx: int) -> void:
	if event is InputEventMouseButton:
		if event.pressed:
			if synchronizer.get_multiplayer_authority() == multiplayer.get_unique_id():
				if event.button_index == MOUSE_BUTTON_LEFT:
					rpc("flip_object")

				elif event.button_index == MOUSE_BUTTON_MASK_RIGHT and open:
					GameManager.player_guess(multiplayer.get_unique_id(), gue)

			else:
				print("You do not have authority to interact with this object.")

@rpc("call_local")
func flip_object():
	if open:
		anim_player.play('Flip')

	else:
		anim_player.play_backwards('Flip')

	open = !open
