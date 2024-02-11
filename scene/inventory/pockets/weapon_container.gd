extends GridContainer

func _ready():
	$Slot1/Item.set_item({"name": "armor/shoe", "qty": 1})
	$Slot2/Item.set_item({"name": "armor/helmet", "qty": 1})
	$Slot3/Item.set_item({"name": "armor/glove", "qty": 1})
	$Slot4/Item.set_item({"name": "armor/plate", "qty": 1})
	
	for i in get_children():
		i.get_children()[0].scale = Vector2(1.5, 1.5)
		i.get_children()[0].position = Vector2(5, 5)
	#$Slot1/Item.scale = Vector2(1.5, 1.5)
	#$Slot1/Item.position = Vector2(5, 5)
