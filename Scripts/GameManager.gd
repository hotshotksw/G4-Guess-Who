extends Node

var Players={}

func _ready():
	Signalbus.guess_character.connect(player_guess)
	pass

func _process(delta):
	pass

func player_guess(player: int, image: Image):
	print(player)
	print(image.get_data())
