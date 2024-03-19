class_name InventoryItems
extends Node

var file_path: String = "res://data/json/player_inventory.json"

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

func update_qty(data, new_qty):
	var all_data = load_all_data()
	for i in range(0, all_data.size()):	
		if all_data[i].id == data.id and all_data[i].name == data.name and data.qty == all_data[i].qty:
			all_data[i].qty = new_qty
			save_items(all_data)
			return true
	return false
	

func stack_item(new_item, old_item, new_qty):
	var data = load_all_data()
	# Update qty
	for i in range(0, data.size()):
		if data[i].id == old_item.data.id and data[i].name == old_item.data.name and data[i].slot_id == old_item.data.slot_id:
			data[i].qty = new_qty
			break
	# Remove new item
	for i in range(0, data.size()):
		if old_item.data.id != new_item.data.id:
			if data[i].id == new_item.data.id and data[i].name == new_item.data.name and data[i].slot_id == new_item.data.slot_id:
				data.remove_at(i)
				break
		else:
			break
	data = regenerate_id(data)
	save_items(data)
	
func regenerate_id(data):
	 #Regenerate id
	for i in range(0, data.size()):
		#var right_id = data[i].id.right(3)
		var left_id = data[i].id.left(data[i].id.length()-3)
		data[i].id = left_id + str(i + 1).pad_zeros(3)
	return data

func remove_item(data: Dictionary):
	var all_data = load_all_data()
	for i in range(0, all_data.size()):	
		if all_data[i].id == data.id and all_data[i].name == data.name:
			all_data.remove_at(i)
			save_items(all_data)
			return true
	return false

func add_item(item: Dictionary, new_id = false):
	var all_data = load_all_data()	
	if new_id:
		item.id = item.id.left(-3) + str(all_data.size()).pad_zeros(3)
	all_data.append(item)
	all_data = regenerate_id(all_data)
	save_items(all_data)
	
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
