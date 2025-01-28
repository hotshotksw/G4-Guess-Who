extends Node

var asking = false

func _on_question_btn_pressed() -> void:
	asking = !asking
	$Ask.visible = asking

func _on_texture_button_pressed() -> void:
	get_tree().quit(0)
	#if multiplayer.is_server():
		## If we're the host, notify all clients before quitting
		#rpc("receive_quit_notification")
	## Clean up and quit
	#multiplayer.multiplayer_peer = null
	#get_tree().quit()


func _on_ask_btn_button_down() -> void:
	GameManager.ask_question(GameManager.questionChar[0], GameManager.questionChar[1])
	GameManager.questionChar.resize(2)
	$Ask/Question.text = GameManager.answer


func _on_ask_btn_button_up() -> void:
	GameManager.advance_turn.rpc()


func _on_turn_property_list_changed() -> void:
	print("Something")
	pass #$"../FirstPersonHud/Turn".text = GameManager.turn
