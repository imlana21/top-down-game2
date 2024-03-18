extends InventorySlot

func _ready():
	refresh_style() 
	parent_name = "BuilderInv"
	inventory = InventoryItems.new()
	inventory_name = "builder"
	connect("gui_input", _on_gui_input)
	connect("mouse_exited", _on_mouse_exited)
	connect("mouse_entered", _on_mouse_entered)

func put_into_slot(new_item, old_item = null, new_qty = 0):
	# Configuration item and move item from parent
	new_item.scale = Vector2(1.2,1.2)
	set_anchor_center(new_item)
	find_parent(parent_name).remove_child(new_item)
	if new_qty > 0 and old_item != null:
		inventory.stack_item(new_item, old_item, new_qty)
		inventory.remove_item(old_item)
		item = null
	inventory.update_slot_position(new_item, slot_id)
	add_child(new_item)
	item = new_item
	refresh_style()

func pick_from_slot():
	# remove child from slot panel
	remove_child(item)
	# move item to parent and make item floating
	item.scale = Vector2(0.8, 0.8)
	set_anchor_center(item)
	find_parent(parent_name).add_child(item)
	# reset item variabel
	item = null
	refresh_style()
