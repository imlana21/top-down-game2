class_name InventorySlot
extends Panel

@onready var item_scene = preload("res://scene/inventory/_items/item.tscn")
var slot_id: int = 0
var item = null
var inventory = null
var parent_name = null
var is_mouse_hovered = false

signal slot_input_event
signal spread_item
signal pick_one_item

func _on_gui_input(event):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		slot_input_event.emit(self)
	
func _input(event):
	if is_mouse_hovered and item != null:
		if Input.is_action_just_pressed("camera_mode"):
			spread_item.emit(self)
		elif Input.is_action_just_pressed("pick_item"):
			pick_one_item.emit(self)
	
func _on_mouse_entered():
	modulate = "eaeaea"
	is_mouse_hovered = true

func _on_mouse_exited():
	modulate = "fff"
	is_mouse_hovered = false	

func refresh_style():
	self.modulate = "fff"

func init_item_into_slot(data):	
	if data != null:
		if item == null:
			item = item_scene.instantiate()
			item.scale = Vector2(1.3, 1.3)
			item.position = Vector2(7, 7)
			add_child(item)
			item.set_item(data)
		else:
			item.set_item(data)
	else:
		if item != null:
			remove_child(item)
		item = null
	refresh_style()

func pick_from_slot():
	# remove child from slot panel
	remove_child(item)
	# move item to parent and make item floating
	find_parent(parent_name).add_child(item)
	# reset item variabel
	item = null
	# refresh inventory
	refresh_style()
	
func pick_from_slot2(holding_item=null):
	if holding_item:
		if item.data.name != holding_item.data.name:
			return null
		item.update_qty(item.data.qty - 1)
		holding_item.update_qty(holding_item.data.qty + 1)
		if item.data.qty < 1:
			remove_child(item)
			refresh_style()
			item = null
		return holding_item
	elif item.data.qty > 1:
		var new_item =  item.duplicate()
		new_item.set_item(item.data)
		new_item.update_qty(1)
		item.update_qty(item.data.qty - 1)
		return new_item
	return null
