extends Node

var asking = false

func _on_question_btn_pressed() -> void:
	asking = !asking
	$Ask.visible = asking
