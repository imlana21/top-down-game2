class_name Inventory
extends Control

#var slot_container: 
var inventory_name: String
	
# Initialize slot number
func _init_slot_id(slot_container: GridContainer):
	var inventory = slot_container.get_children()
	for index in inventory.size():
		inventory[index].slot_id = index

# Calling data from memory
func get_data(inv_name: String, slot_container: GridContainer):
	var inv_class = InventoryItems.new()
	inv_class.regenerate_id()
	var inv_data = inv_class.load_data(inv_name) 
	var index = 0
	var temp_data = []
	# Set null for default
	for i in range(slot_container.get_children().size()):
		temp_data.append(null)
	# Call Data
	for d in inv_data:
		for slot in slot_container.get_children():
			if d.slot_id == slot.slot_id and d.inventory == inv_name and temp_data[index] == null:
				temp_data[index] = d
			index += 1
		index = 0
	return temp_data

# applying data to the inventory panel after calling data from memory
func set_inventory(slot_container: GridContainer, inv_name = null):
	var data = null
	if inv_name:
		data = get_data(inv_name, slot_container)
	else:
		data = get_data(inventory_name, slot_container)
	var index = 0
	for slot in slot_container.get_children():
		slot.init_item_into_slot(data[index])
		index += 1

func get_empty_slot(inv_name, slot_container):
	var data = get_data(inv_name, slot_container)
	var index = 0
	for d in data:
		if d == null:
			return index
		index = index + 1
	return -1

func spread_item(slot_data: Dictionary, slot_container: GridContainer, inv_name: String) -> void:
	var data = slot_data
	if data.qty > 1:
		var mean = floor(data.qty / 2)
		var qty1 = data.qty - mean
		var qty2 = data.qty - qty1
		var inv_manager = InventoryItems.new()
		inv_manager.remove_item(data)
		data.qty = qty1
		inv_manager.add_item(data)
		data.slot_id = get_empty_slot(inv_name, slot_container)
		data.qty = qty2
		inv_manager.add_item(data, true)
		_init_slot_id(slot_container)
		set_inventory(slot_container, inv_name)