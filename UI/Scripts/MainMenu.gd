extends Control


func _on_start_btn_pressed() -> void:
	get_tree().change_scene_to_file("res://multiplayerScene.tscn")


func _on_rules_btn_pressed() -> void:
	get_tree().change_scene_to_file("res://UI/Scenes/Rules.tscn")


func _on_settings_btn_pressed() -> void:
	get_tree().change_scene_to_file("res://UI/Scenes/Settings.tscn")


func _on_back_btn_pressed() -> void:
	get_tree().change_scene_to_file("res://UI/Scenes/TitleScreen.tscn")


func _on_save_btn_pressed() -> void:
	pass # Replace with function body.
