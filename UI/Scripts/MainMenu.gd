extends Control

var changeSFX
var changeVol

var change = 1

func _on_start_btn_pressed() -> void:
	AudioLoader.play_sound("btn")
	get_tree().change_scene_to_file("res://multiplayerScene.tscn")


func _on_rules_btn_pressed() -> void:
	AudioLoader.play_sound("btn")
	get_tree().change_scene_to_file("res://UI/Scenes/Rules.tscn")


func _on_settings_btn_pressed() -> void:
	AudioLoader.play_sound("btn")
	get_tree().change_scene_to_file("res://UI/Scenes/Settings.tscn")


func _on_back_btn_pressed() -> void:
	AudioLoader.play_sound("btn")
	get_tree().change_scene_to_file("res://UI/Scenes/TitleScreen.tscn")


func _on_save_btn_pressed() -> void:
	AudioLoader.play_sound("save")
	if(changeVol != null): 
		AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Music"), changeVol)
	if(changeSFX != null):
		AudioServer.set_bus_volume_db(AudioServer.get_bus_index("SFX"), changeSFX)

func _on_volume_value_changed(value: float) -> void:
	changeVol = linear_to_db(value)


func _on_ready() -> void:
	$Volume.value = db_to_linear(AudioServer.get_bus_volume_db(1))
	$sfx.value = db_to_linear(AudioServer.get_bus_volume_db(2))


func _on_sfx_value_changed(value: float) -> void:
	changeSFX = linear_to_db(value)


func _on_pressed() -> void:
	AudioLoader.play_music("Scene2")


func _on_texture_button_pressed() -> void:
	get_tree().quit(0)
