extends InventorySlot

func _ready():
	inventory_name = get_parent().get_parent().inv_name
	parent_name = "ChestStore"
	self.connect("gui_input", _on_gui_input)
	inventory = InventoryItems.new()
	
func put_into_slot(new_item, old_item = null, new_qty = 0):
	# Configuration item and move item from parent
	new_item.scale = Vector2(1.4, 1.4)
	new_item.position = Vector2(5, 5)
	find_parent(parent_name).remove_child(new_item)
	if new_qty > 0 and old_item != null:
		inventory.stack_item(new_item, old_item, new_qty)
		inventory.remove_item(old_item)
		item = null
	inventory.update_slot_position(new_item, slot_id)
	inventory.change_inventory(new_item, inventory_name)
	self.add_child(new_item)
	item = new_item
	refresh_style()

