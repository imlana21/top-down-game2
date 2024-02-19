extends Panel

var pid = null
var ptype = null
var ptime_cook = null
var pname = null
var pimg = null
var pingredient = null
var pstatus = null

signal select_craft

func set_product_id(val):
	pid = val
	
func set_product_type(val):
	ptype = val
	
func set_time_cook(val):
	ptime_cook = val

func set_product_name(val):
	pname = val

func set_img_path(val):
	pimg = val
	_init_item_into_slot(val)
	
func set_ingredient(val):
	pingredient = val
	
func set_status(val):
	pstatus = val

func _init_item_into_slot(img_path):
	var item = load("res://scene/crafting_bench/item/product_item.tscn").instantiate()
	if img_path != null:
		item.scale = Vector2(1.2, 1.2)
		item.position = Vector2(7, 7)
		add_child(item)
		item.set_item(img_path)
	else:
		item = null
	refresh_style()

func refresh_style():
	self.modulate = "fff"

func _on_gui_input(event):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		# Signal send to product_panel
		select_craft.emit(self)
