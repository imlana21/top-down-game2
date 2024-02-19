extends InventorySlot

signal slot_hovered
signal slot_unhovered

func _ready():
	refresh_style() 
	parent_name = "Pockets"
	inventory = InventoryItems.new()
	connect("mouse_entered", _on_mouse_entered)
	connect("mouse_exited", _on_mouse_exited)

func put_into_slot(new_item, old_item = null, new_qty = 0):
	# Configuration item and move item from parent
	new_item.scale = Vector2(1.3, 1.3)
	new_item.position = Vector2(7, 7)
	find_parent(parent_name).remove_child(new_item)
	if new_qty > 0 and old_item != null:
		inventory.stack_item(new_item, old_item, new_qty)
		inventory.remove_item(old_item)
		item = null
	inventory.update_slot_position(new_item, slot_id)
	self.add_child(new_item)
	item = new_item
	refresh_style()
	
func _on_mouse_entered():
	slot_hovered.emit(self)
	modulate = "eaeaea"

func _on_mouse_exited():
	slot_unhovered.emit(self)
	modulate = "fff"
