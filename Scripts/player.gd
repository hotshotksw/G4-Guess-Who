extends Node3D

@onready var camera = $MeshInstance3D/Boy/Camera3D as Camera3D
@onready var head = $MeshInstance3D/Boy
@onready var ray = $MeshInstance3D/Boy/Camera3D/RayCast3D as RayCast3D

var x_sensitivity = 0.01 as float
var y_sensitivity = 0.01 as float

var usingUI = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$MultiplayerSynchronizer.set_multiplayer_authority(str(name).to_int())
	if $MultiplayerSynchronizer.get_multiplayer_authority() == multiplayer.get_unique_id():
		camera.make_current()

	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func _input(event: InputEvent) -> void:
	if $MultiplayerSynchronizer.get_multiplayer_authority() != multiplayer.get_unique_id():
		return
	
	if(Input.is_key_pressed(KEY_SHIFT)): usingUI = !usingUI

	if Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
		if event is InputEventMouseMotion:
			head.rotate_y(-event.relative.x * x_sensitivity)
			head.rotation.x = clamp(head.rotation.x + event.relative.y * y_sensitivity, 
				deg_to_rad(-30), deg_to_rad(90))

		elif event is InputEventMouseButton and event.pressed:
			if ray.is_colliding():
				var node = ray.get_collider()

				while node and not node.has_method("_on_area_3d_input_event"):
					node = node.get_parent()

				if node:
					var custom_event = InputEventMouseButton.new()
					custom_event.button_index = event.button_index
					custom_event.pressed = true
					node._on_area_3d_input_event(camera, custom_event, ray.get_collision_point(),
						ray.get_collision_normal(), ray.get_collider_shape())

		elif event.is_action_pressed("ui_cancel"):
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

	elif Input.get_mouse_mode() == Input.MOUSE_MODE_VISIBLE and usingUI == false:
		if event is InputEventMouseButton and event.pressed:
			Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

@rpc("any_peer")
func set_image(image):
	var char_image = get_node("MeshInstance3D/Boy/Camera3D/FirstPersonHud/CharImage") as TextureRect
	char_image.texture = ImageTexture.create_from_image(image)


# if $MultiplayerSynchronizer.get_multiplayer_authority() == multiplayer.get_unique_id()
# -- if true, following code will occur
