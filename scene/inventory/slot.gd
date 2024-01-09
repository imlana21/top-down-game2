extends Panel

@onready var Item = preload("res://scene/inventory/items/item.tscn")
var slot_index: int = 0
var item = null

signal slot_input_event

func _ready():
	# modify signal gui_input from godot
	connect("gui_input", _on_gui_input)
	# fill inventori with random item
	if randi() % 3 == 0:
		item = Item.instantiate()
		item.scale = Vector2(1.4, 1.4)
		item.position = Vector2(5, 0)
		add_child(item)
	refresh_style()

func _on_gui_input(event):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		slot_input_event.emit(event, self)

func refresh_style():
	if item == null:
		self.modulate = "9c9c9c94"
	else:
		self.modulate = "fff"

func pick_from_slot():
	# remove child from slot panel
	remove_child(item)
	# move item to parent and make item floating
	#item.z_index = 99
	find_parent("Inventory").add_child(item)
	# reset item variabel
	item = null
	# refresh inventory
	refresh_style()

func put_into_slot(new_item):
	# localization parameter
	item = new_item
	# Configuration item and move item from parent
	item.scale = Vector2(1.4, 1.4)
	item.position = Vector2(5, 0)
	find_parent("Inventory").remove_child(item)
	# move item to slot panel
	self.add_child(item)
	refresh_style()
	
