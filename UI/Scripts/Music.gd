extends Node

@onready var audio_player: AudioStreamPlayer2D = $Music
@onready var sfx_player: AudioStreamPlayer2D = $SFX_btn

var music_tracks = {
	"Scene1": "res://Assets/Local Forecast - Elevator.mp3",
	"Scene2": "res://Assets/Winner Winner!.mp3"
}

var sfx_tracks = {
	"btn": "res://Assets/btn.wav",
	"save": "res://Assets/save.wav"
}


func play_music(scene_name: String) -> void:
	if scene_name in music_tracks:
		var music_path = music_tracks[scene_name]
		var stream = load(music_path)
		if stream:
			audio_player.stream = stream
			audio_player.play()
		else:
			print("Error: Could not load music at path:", music_path)
	else:
		print("No music defined for scene:", scene_name)

func play_sound(sfx_type: String) -> void:
	if sfx_type in sfx_tracks:
		var sfx_path = sfx_tracks[sfx_type]
		var stream = load(sfx_path)
		if stream:
			sfx_player.stream = stream
			sfx_player.play()
		else:
			print("Error: Could not load sound at path:", sfx_path)
	else:
		print("No sound defined for:", sfx_type)
