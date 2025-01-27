extends Node

var asking = false

func _on_question_btn_pressed() -> void:
	asking = !asking
	$Ask.visible = asking


func _on_ask_btn_pressed() -> void:
	GameManager.ask_question(GameManager.questionChar[0], GameManager.questionChar[1])

func _on_texture_button_pressed() -> void:
	get_tree().quit(0)
