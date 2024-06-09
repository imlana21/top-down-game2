extends Panel

var is_mouse_hovered: bool = false
var item = null
var slot_id: int = 0

@onready var item_scene = preload ("res://scene/world/warp_empty/chest_item/item.tscn")

signal chest_panel_clicked

func mouse_hovered() -> void:
	self_modulate = "ff9900c9"
	is_mouse_hovered = true

func mouse_unhovered() -> void:
	self_modulate = "fff"
	is_mouse_hovered = false

func _on_mouse_entered() -> void:
	pass

func _on_mouse_exited() -> void:
	mouse_unhovered()

func _on_gui_input(event:InputEvent) -> void:
	mouse_hovered()
	if Autoload.paused_on == 'popup_warp_chest':
		if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
			var inv_name = get_parent().get_parent().get_parent().inv_name
			chest_panel_clicked.emit(self, inv_name)

func init_item_into_slot(data, item_size=null) -> void:
	if data != null:
		if item == null:
			item = item_scene.instantiate()
			item.scale = Vector2(1.3, 1.3)
			item.anchors_preset = Control.PRESET_CENTER
			add_child(item)
			item.set_item(data)
		else:
			item.set_item(data)
	else:
		if item != null:
			item.reset_item()

func reset_panel() -> void:
	self.self_modulate = "fff"
	for i in get_children():
		item = null
		i.reset_item()
		if item:
			remove_child(item)
			item = null
	
func pick_from_slot(parent_name: String):
	var new_item = item.duplicate()
	new_item.data = item.data
	new_item.scale = Vector2(1.2, 1.2)
	find_parent(parent_name).add_child(new_item)
	# refresh inventory 
	reset_panel()
	return new_item

func put_into_slot(parent_name, new_item, old_item=null, new_qty=0) -> void:
	# Configuration item and move item from parent
	var inv_manager = InventoryItems.new()
	new_item.scale = Vector2(1.2, 1.2)
	set_anchor_center(new_item)
	find_parent(parent_name).remove_child(new_item)
	if new_qty > 0 and old_item != null:
		inv_manager.stack_item(new_item, old_item, new_qty)
		item = null
	inv_manager.update_slot_position(new_item, slot_id)
	set_anchor_center(new_item)
	add_child(new_item)
	item = new_item
	self.self_modulate = "fff"
	
func update_inventory_name(holding_item, inv_name: String) -> void:
	var inv_manager = InventoryItems.new()
	inv_manager.update_inv_name(holding_item.data, inv_name)

func set_anchor_center(i):
	i.anchors_preset = Control.PRESET_CENTER