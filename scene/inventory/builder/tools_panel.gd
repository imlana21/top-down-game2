extends InventorySlot

func _ready():
	refresh_style() 
	parent_name = "BuilderInv"
	inventory = InventoryItems.new()
	inventory_name = "tools"
	connect("gui_input", _on_gui_input)
	connect("mouse_exited", _on_mouse_exited)
	connect("mouse_entered", _on_mouse_entered)

func put_into_slot(new_item, old_item = null, new_qty = 0):
	print("new_item")

func pick_from_slot2(holding_item=null):
	if holding_item:
		return false
	var new_item = item.duplicate()
	new_item.scale = Vector2(0.8, 0.8)
	new_item.data = item.data
	set_anchor_center(new_item)
	find_parent(parent_name).add_child(new_item)
	# refresh inventory
	refresh_style()
	return new_item
	
func _on_gui_input(event):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		slot_input_event.emit(self, "tools")
