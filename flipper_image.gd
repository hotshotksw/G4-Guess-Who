extends Node3D

@export var texture = preload("res://models/wpwh1qb3.jpg")

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
