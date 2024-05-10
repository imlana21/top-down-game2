class_name InventorySlot
extends Panel

@onready var item_scene = preload("res://scene/inventory/_items/item.tscn")
var slot_id: int = 0
var item = null
var inventory_name = null
var parent_name = null
var is_mouse_hovered = false

signal inv_panel_hovered
signal inv_panel_unhovered
signal inv_panel_clicked
signal spread_item
signal pick_one_item

func _on_gui_input(event) -> void:
	inv_panel_hovered.emit(self)
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		inv_panel_clicked.emit(self, inventory_name)
	
func _input(event) -> void:
	if is_mouse_hovered and item != null:
		if Input.is_action_just_pressed("camera_mode"):
			spread_item.emit(self)
		elif Input.is_action_just_pressed("pick_item"):
			pick_one_item.emit(self)
	
func _on_mouse_entered() -> void:
	mouse_hovered()

func mouse_hovered() -> void:
	# modulate = "eaeaea"
	modulate = "80ffff"
	is_mouse_hovered = true	

func _on_mouse_exited() -> void:
	if inventory_name != null:
		inv_panel_unhovered.emit(inventory_name)
	mouse_unhovered()

func mouse_unhovered() -> void:
	modulate = "fff"
	is_mouse_hovered = false	

func refresh_style() -> void:
	self.modulate = "fff"

func init_item_into_slot(data, item_size = null) -> void:	
	if data != null:
		if item == null:
			item = item_scene.instantiate()
			item.scale = Vector2(1.3, 1.3)
			set_anchor_center(item)
			add_child(item)
			item.set_item(data)
		else:
			item.set_item(data)
	else:
		if item != null:
			remove_child(item)
		item = null
	refresh_style()
	
func pick_from_slot(holding_item = null) -> void:
	# remove child from slot panel
	remove_child(item)
	# move item to parent and make item floating
	item.scale = Vector2(0.8, 0.8)
	set_anchor_center(item)
	find_parent(parent_name).add_child(item)
	# reset item variabel
	item = null
	refresh_style()
	
func pick_one_from_slot(holding_item=null):
	var inv_manager = InventoryItems.new()
	if holding_item:
		if item.data.name != holding_item.data.name:
			return null
		item.update_qty(item.data.qty - 1)
		holding_item.update_qty(holding_item.data.qty + 1)
		inv_manager.update_qty(item.data, item.data.qty - 1)
		if item.data.qty < 1:
			remove_child(item)
			refresh_style()
			item = null
		return holding_item
	elif item.data.qty > 1:
		var new_item =  item.duplicate()
		new_item.set_item(item.data)
		new_item.update_qty(1)
		inv_manager.update_qty(item.data, item.data.qty - 1)
		item.update_qty(item.data.qty - 1)
		return new_item
	return null

func put_into_slot(new_item, old_item = null, new_qty = 0) -> void:
	# Configuration item and move item from parent
	var inv_manager = InventoryItems.new()
	new_item.scale = Vector2(1.2,1.2)
	set_anchor_center(new_item)
	find_parent(parent_name).remove_child(new_item)
	if new_qty > 0 and old_item != null:
		inv_manager.stack_item(new_item, old_item, new_qty)
		item = null
	inv_manager.update_slot_position(new_item, slot_id)
	set_anchor_center(new_item)
	add_child(new_item)
	item = new_item
	refresh_style()
	
func update_inventory_type(holding_item, inv_name: String) -> void:
	var inv_manager = InventoryItems.new()
	inv_manager.update_inv_name(holding_item.data, inv_name)

func set_anchor_center(i):
	i.anchors_preset = Control.PRESET_CENTER
