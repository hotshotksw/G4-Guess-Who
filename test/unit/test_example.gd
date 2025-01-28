extends GutTest

# Loads main game scene and gets all nodes in "Board" group. Afterwards, gets all
# flippers from one board and asserts that all are properly loaded and AREN'T null.
func test_flippers():
	var MyScene = load('res://testscene.tscn').instantiate()
	get_tree().root.add_child(MyScene)
	var boards = get_tree().get_nodes_in_group("Board")
	var flippers = boards[0].get_children()
	for flipper in flippers:
		assert_not_null(flipper)
	
# Loads main game scene and gets all nodes in "Board" group. Afterwards, gets
# first flipper's image and ensures that the correct image is loaded.
func test_flipper_image():
	var MyScene = load('res://testscene.tscn').instantiate()
	get_tree().root.add_child(MyScene)
	var boards = get_tree().get_nodes_in_group("Board")
	var flippers = boards[0].get_children()
	var c : Flipper = flippers[0]
	
	assert_eq(c.image.resource_path, "res://Assets/Characters/whiteguy.jpg")

# Tests if Game Manager adds player to array and that it can properly pull it
# from the array using its ID.
func test_player_added():
	var MyScene = load('res://testscene.tscn').instantiate()
	get_tree().root.add_child(MyScene)
	
	GameManager.add_player("Jim", 1)
	var player = GameManager.get_player_by_id(1)
	assert_not_null(player)
	#GameManager.Players[0]['PlayerRef'] = player
	#GameManager.select_player_image()
	#assert_not_null(GameManager.Players[0]['image'])
