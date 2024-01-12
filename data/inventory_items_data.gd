extends Node
class_name InventoryItems

var file_path: String = "res://data/json/items.json"

func load_data():
	if !FileAccess.file_exists(file_path):
		print("File not found")
		return
	var file = FileAccess.open(file_path, FileAccess.READ)
	file = file.get_as_text()
	file = JSON.parse_string(file)
	return file

func save_items(data):
	var json_string = JSON.stringify(data)
	var file = FileAccess.open(file_path, FileAccess.WRITE)
	file.store_line(json_string)
	file.close()
	
func search_by_name(item_name):
	for data in load_data():
		if data.name == item_name:
			return data

func inc_qty(item_name, qty):
	var data = load_data()
	var state_inc = false
	var index = -1
	
	for i in range(data.size()):
		if data[i].name == item_name:
			if int(data[i].qty) + qty <= int(data[i].stack_size):
				data[i].qty = str(int(data[i].qty) + qty)
				state_inc = false
			elif !state_inc:
				state_inc = true
				index = i
				
	if state_inc:
		var temp = data[index].duplicate()
		temp.id = str(data.size() + 1)
		temp.qty = str(qty)
		data.append(temp)
	save_items(data)
