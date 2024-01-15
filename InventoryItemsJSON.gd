extends Node
class_name InventoryItems

var file_path: String = "res://data/json/player_inventory.json"

func load_all_data():
	if !FileAccess.file_exists(file_path):
		print("File not found")
		return
	var data = FileAccess.get_file_as_string(file_path)
	data = JSON.parse_string(data)
	return data
	
func save_items(data):
	var json_string = JSON.stringify(data)
	var file = FileAccess.open(file_path, FileAccess.WRITE)
	file.store_line(json_string)
	file.close()
	
func search_by_name(item_name):
	for data in load_all_data():
		if data.name == item_name:
			return data

func inc_qty(item):
	var data = load_all_data()
	var state_inc = false
	if data.size() < 1:
		state_inc = true
	else:
		for i in range(0, data.size()):
			if data[i].name == item.name and data[i].inventory == item.inventory:
				if int(data[i].qty) + int(item.qty) <= int(data[i].stack_size):
					data[i].qty = str(int(data[i].qty) + int(item.qty))
					state_inc = false
					break
			elif !state_inc:
				state_inc = true
				
	if state_inc:
		var temp = item.duplicate()
		temp.id = str(data.size() + 1)
		data.append(temp)
		
	save_items(data)
	
func load_data(inv):
	var temp_data = []
	for d in load_all_data():
		if d.inventory == inv:
			temp_data.append(d)
	return temp_data
	
func change_inventory(item, inv_name):
	var data = load_all_data()
	for i in range(data.size()):
		if data[i].name == item.item_name and data[i].id == item.item_id:
			data[i].inventory = inv_name
	save_items(data)
