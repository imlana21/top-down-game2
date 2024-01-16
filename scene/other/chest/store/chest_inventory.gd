extends Control

@onready var slot_container = $Container
const inventory_name = "chest"

func _ready():
	_init_slot_id()

func _input(event):
	if Input.is_action_just_released("pick_item"):
		set_inventory()	

func set_inventory():
	var data = get_data(inventory_name)
	var index = 0
	
	for slot in slot_container.get_children():
		slot.init_item_into_slot(data[index])
		index += 1

func get_data(inv_name):
	var inv_class = InventoryItems.new()
	var data = inv_class.load_data(inventory_name) 
	var index = 0
	var temp_data = []
	
	for i in range(slot_container.get_children().size()):
		temp_data.append(null)
		
	for arr in data:
		for slot in slot_container.get_children():
			if arr.slot_id == slot.slot_id and arr.inventory == inv_name and temp_data[index] == null:
				temp_data[index] = arr
			index += 1
		index = 0
	return temp_data
	
func _init_slot_id():
	var inventory = slot_container.get_children()
	for index in inventory.size():
		inventory[index].slot_id = index

func get_empty_slot(inv_name):
	var data = get_data(inv_name)
	var index = 0
	for d in data:
		if d == null:
			return index
		index = index + 1
	return null
