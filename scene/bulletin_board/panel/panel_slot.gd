extends Panel

var item_scene = null

func refresh_style():
	self.modulate = "fff"

func set_item(data):
	clear_child()
	if data == null:
		item_scene = null
	else:
		item_scene = load("res://scene/inventory/_items/item.tscn").instantiate()
		item_scene.scale = Vector2(1.4, 1.4)
		item_scene.position = Vector2(8, 8)
		add_child(item_scene)
		add_check_list(data)
		item_scene.set_item(data)
	refresh_style()

func clear_child():
	if get_children().size() > 0:
		for i in get_children():
			remove_child(i)

func add_check_list(data):
	var inv = InventoryItems.new()
	if data.qty < inv.get_total_qty_by_name(data.name):
		var check_scene = load("res://scene/bulletin_board/other/checklist.tscn").instantiate()
		check_scene.scale = Vector2(2.0, 2.0)
		check_scene.set_anchors_preset(Control.PRESET_CENTER_TOP)
		add_child(check_scene)
