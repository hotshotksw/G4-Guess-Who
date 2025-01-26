extends ItemList

enum Gender { MALE, FEMALE }
enum HairColor { BLONDE, BROWN, BLACK, RED, WHITE }
enum EyeColor { BLUE, BROWN, GREEN }
enum Accessories { NONE, GLASSES, HAT, EARRINGS }
enum FacialHair { NONE, MUSTACHE, BEARD }

var Char_Gender : Gender
var Char_HairColor : HairColor
var Char_EyeColor : EyeColor
var Char_Accessories : Accessories
var Char_FacialHair : FacialHair

var filter;

var itm
var fltr

func _ready() -> void:
	filter = get_child(0);


func _on_item_selected(index: int) -> void:
	match index:
		0:
			itm = "gender"
			return _item_change(Gender)
		1:
			itm = "coloered hair"
			return _item_change(HairColor)
		2:
			itm = "colored eyes"
			return _item_change(EyeColor)
		3:
			itm = "accessory"
			return _item_change(Accessories)
		4:
			itm = "facial hair"
			return _item_change(FacialHair)
		"_":
			print("There was an error")

func _item_change(items) -> void:
	#If filter isn't empty remove all items
	if(filter):
		for i in filter.item_count:
			filter.remove_item(0)
		
	for item in items:
		filter.add_item(item)


func _on_filter_item_selected(index: int) -> void:
	
	$"../Ask_btn".disabled = false;
	
	#enable button
	
	match index:
		0:
			return _item_change(Gender)
		1:
			return _item_change(HairColor)
		2:
			return _item_change(EyeColor)
		3:
			return _item_change(Accessories)
		4:
			return _item_change(FacialHair)
		"_":
			print("There was an error")
