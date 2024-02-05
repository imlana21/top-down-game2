class_name InventoryItems
extends Node

var file_path: String = "res://data/json/player_inventory.json"
var all_data: Array

func load_all_data():
	if !FileAccess.file_exists(file_path):
		print("File not found")
		return
	var data = FileAccess.get_file_as_string(file_path)
	data = JSON.parse_string(data)
	return data
	
func load_data(inv):
	var temp_data = []
	for d in load_all_data():
		if d.inventory == inv:
			temp_data.append(d)
	return temp_data

func save_items(data):
	var json_string = JSON.stringify(data)
	var file = FileAccess.open(file_path, FileAccess.WRITE)
	file.store_line(json_string)
	file.close()
	
func search_by_name(item_name):
	for data in load_all_data():
		if data.name == item_name:
			return data

func search_all_by_name(item_name):
	var temp = []
	for data in load_all_data():
		if data.name == item_name:
			temp.append(data)
	return temp

func get_total_qty_by_name(item_name):
	var data = search_all_by_name(item_name)
	var qty = 0
	if data.size() > 0:
		for d in data:
			qty += d.qty
	return qty

func inc_qty(item, slot_id, kategory):
	var data = load_all_data()
	var state_inc = false
	if data.size() < 1:
		state_inc = true
	else:
		for i in range(0, data.size()):
			if data[i].name == item.name and data[i].inventory == item.inventory:
				if int(data[i].qty) + int(item.qty) <= int(data[i].stack_size):
					data[i].qty = int(data[i].qty) + int(item.qty)
					state_inc = false
					break
			elif !state_inc:
				state_inc = true
	if state_inc:
		var temp = item.duplicate()
		temp.id = kategory + str(data.size() + 1).pad_zeros(3)
		temp.slot_id = slot_id
		data.append(temp)
		
	save_items(data)

func stack_item(new_item, old_item, new_qty):
	var data = load_all_data()
	# Update qty
	for i in range(0, data.size()):
		if data[i].id == new_item.data.id and data[i].name == new_item.data.name:
			data[i].qty = new_qty
			break
	# Remove old item
	for i in range(0, data.size()):
		if data[i].id == old_item.data.id and data[i].name == old_item.data.name:
			data.remove_at(i)
			break
	# Update id
	for i in range(0, data.size()):
		data[i].id = i
		
	save_items(data)

func remove_item(item):
	var data = load_all_data()
	for i in range(0, data.size()):	
		if data[i].id == item.data.id and data[i].name == item.data.name:
			data.remove_at(i)
			break
	save_items(data)
	
func change_inventory(item, inv_name):
	var data = load_all_data()
	for i in range(data.size()):
		if data[i].name == item.data.name and data[i].id == item.data.id:
			data[i].inventory = inv_name
	save_items(data)

func update_slot_position(item, slot_id):
	var data = load_all_data()
	for i in range(data.size()):
		if data[i].id == item.data.id:
			data[i].slot_id = slot_id
	save_items(data)
