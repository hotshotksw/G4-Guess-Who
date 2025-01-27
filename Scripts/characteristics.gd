extends Node

class_name Characteristics

# Enums for character features
enum Gender { MALE, FEMALE }
enum HairColor { BLONDE, BROWN, BLACK, RED, WHITE, NONE }
enum EyeColor { BLUE, BROWN, GREEN }
enum Accessories { NONE, GLASSES, HAT, EARRINGS }
enum FacialHair { NONE, MUSTACHE, BEARD }

@export var Char_Gender : Gender
@export var Char_HairColor : HairColor
@export var Char_EyeColor : EyeColor
@export var Char_Accessories : Accessories
@export var Char_FacialHair : FacialHair

# Function to generate a character with random features
static func generate_random_character() -> Dictionary:
	return {
		"gender": Gender.values()[randi() % Gender.size()],
		"hair_color": HairColor.values()[randi() % HairColor.size()],
		"eye_color": EyeColor.values()[randi() % EyeColor.size()],
		"accessories": Accessories.values()[randi() % Accessories.size()],
		"facial_hair": FacialHair.values()[randi() % FacialHair.size()]
	}
	
	# Function to describe a character and print it to the console
static func describe_character(character: Dictionary) -> void:
	var description = "Character Description:\n"
	description += "Gender: %s\n" % Gender.keys()[character["gender"]]
	description += "Hair Color: %s\n" % HairColor.keys()[character["hair_color"]]
	description += "Eye Color: %s\n" % EyeColor.keys()[character["eye_color"]]
	description += "Accessories: %s\n" % Accessories.keys()[character["accessories"]]
	description += "Facial Hair: %s\n" % FacialHair.keys()[character["facial_hair"]]
	print(description)

#func _ready():
	## Call the function to generate and describe a random character
	#var character = generate_random_character()
	#describe_character(character)
