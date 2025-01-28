extends ItemList

var char = Characteristics.new()
var filter;
var itm;
var fltr;
var search = GameManager.questionChar;

func _ready() -> void:
	filter = get_child(0);


func _on_item_selected(index: int) -> void:
	
	search[0] = get_item_text(index);
	
	match index:
		0:
			itm = "Is your character "
			return _item_change(char.Gender)
		1:
			itm = "Is your character's hair color "
			return _item_change(char.HairColor)
		2:
			itm = "Is your character's eye color "
			return _item_change(char.EyeColor)
		3:
			itm = "Does your character wear "
			return _item_change(char.Accessories)
		4:
			itm = "Does your character have "
			return _item_change(char.FacialHair)
		"_":
			print("There was an error")

func _item_change(items) -> void:
	#If filter isn't empty remove all items
	if(filter):
		search[1] = null
		$"../Ask_btn".disabled = true
		for i in filter.item_count:
			filter.remove_item(0)
		
	for item in items:
		filter.add_item(item)


func _on_filter_item_selected(index: int) -> void:
	
	#if(!GameManager.Players[GameManager.current_turn]['playerRef'].isTurn): return
	
	$"../Ask_btn".disabled = false;
	
	fltr = filter.get_item_text(index) + "."
	
	if(fltr == "NONE." and itm == "Does your character wear "):
		fltr = "no accessories."
	elif(fltr == "NONE." and itm == "Does your character have "):
		fltr = "no facial hair."
	elif(fltr == "NONE." and itm == "Is your character's hair color "):
		itm = "Does your character have "
		fltr = "no hair."
	
	search[1] = index;
	
	$"../Question".text = itm + fltr
