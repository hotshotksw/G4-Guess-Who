extends Node3D

@export var texture = preload("res://models/wpwh1qb3.jpg")
var open = true
@onready var anim_player = $AnimationPlayer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var image = texture.get_image()
	#image.rotate_90(CLOCKWISE)
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
			if event.button_index == MOUSE_BUTTON_LEFT:
				if open:
					anim_player.play('Flip')
					print('Close')

				else:
					anim_player.play_backwards('Flip')
					print('Open')

				open = !open

			elif event.button_index == MOUSE_BUTTON_MASK_RIGHT and open:
				print('Are you sure you want to guess them?')
