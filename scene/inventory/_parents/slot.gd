class_name InventorySlot
extends Panel

@onready var item_scene = preload("res://scene/inventory/_items/item.tscn")
var slot_id: int = 0
var item = null
var inventory = null
var parent_name = null

signal slot_input_event

func _on_gui_input(event):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		slot_input_event.emit(self)

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
