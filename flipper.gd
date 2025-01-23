extends Node3D
var open = true
@onready var anim_player = $AnimationPlayer

func _on_area_3d_input_event(camera: Node, event: InputEvent, event_position: Vector3, normal: Vector3, shape_idx: int) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			if open:
				anim_player.play('Flip')
				print('Close')
			else:
				anim_player.play_backwards('Flip')
				print('Open')
			open = !open
		elif event.button_index == MOUSE_BUTTON_MASK_RIGHT and event.pressed and open:
			print('Are you sure you want to guess them?')
