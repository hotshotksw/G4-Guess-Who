extends Node

var asking = false

func _on_question_btn_pressed() -> void:
	asking = !asking
	$Ask.visible = asking


func _on_ask_btn_pressed() -> void:
	GameManager.ask_question(GameManager.questionChar[0], GameManager.questionChar[1])
