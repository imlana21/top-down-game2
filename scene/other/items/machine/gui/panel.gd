extends Panel

var item: Dictionary

func set_item(val):
	var crafting_item = load("res://scene/crafting_bench/item/crafting_item.tscn").instantiate()
	item = val
	crafting_item.set_item(item)
	crafting_item.scale = Vector2(0.8, 0.8)
	add_child(crafting_item)

func reset_item():
	item = {}
	if get_child_count() > 0:
		for i in get_children():
			remove_child(i)