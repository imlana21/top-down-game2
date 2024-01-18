extends Panel

@onready var Item = preload("res://scene/inventory/items/item.tscn")
var slot_id: int = 0
var item = null
var inventory_name
var inventory

signal slot_input_event

func _ready():
	# modify signal gui_input from godot
	connect("gui_input", _on_gui_input)
	inventory_name = get_parent().get_parent().inventory_name
	inventory = InventoryItems.new()
	refresh_style() 

func _on_gui_input(event):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		slot_input_event.emit(self)
	
func refresh_style():
	self.modulate = "fff"

func pick_from_slot():
	# remove child from slot panel
	remove_child(item)
	# move item to parent and make item floating
	find_parent("ChestStore").add_child(item)
	# reset item variabel
	item = null
	# refresh inventory
	refresh_style()

func put_into_slot(new_item):
	# localization parameter
	item = new_item
	# Configuration item and move item from parent
	item.scale = Vector2(1.4, 1.4)
	item.position = Vector2(5, 5)
	find_parent("ChestStore").remove_child(item)
	#print(new_item.slot_id)
	# move item to slot panel
	self.add_child(item)
	inventory.update_slot_position(new_item, slot_id)
	inventory.change_inventory(new_item,inventory_name)
	refresh_style()

func init_item_into_slot(data):		
	if item == null:
		item = Item.instantiate()
		item.scale = Vector2(1.4, 1.4)
		item.position = Vector2(5, 5)
		add_child(item)
		item.set_item(data)
	else:
		item.set_item(data)
	refresh_style()
