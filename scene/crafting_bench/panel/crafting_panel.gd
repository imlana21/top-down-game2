extends HBoxContainer

var pingredient = null
var pid = null

func set_pingredient(val):
	var crafting_item = load("res://scene/crafting_bench/item/crafting_item.tscn").instantiate()
	pingredient = val
	reset_child()
	crafting_item.set_item(pingredient)
	crafting_item.scale = Vector2(0.8, 0.8)
	$Panel.add_child(crafting_item)
	
func set_pid(val):
	pid = val

func set_operator(val):
	$Label.text = val

func set_result(pname, pimg):
	var crafting_item = load("res://scene/crafting_bench/item/product_item.tscn").instantiate()
	reset_child()
	crafting_item.set_item(pimg)
	crafting_item.scale = Vector2(0.7, 0.7)
	crafting_item.position = Vector2(0, -5)
	$Panel.add_child(crafting_item)
	
func reset_child():
	if $Panel.get_child_count() > 0:
		for children in $Panel.get_children():
			$Panel.remove_child(children)
