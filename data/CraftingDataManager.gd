class_name CraftingDataManager
extends Node

var file_path: String = "res://data/json/crafting_product.json"

func get_all_data():
	if !FileAccess.file_exists(file_path):
		print("File not found")
		return
	var data = FileAccess.get_file_as_string(file_path)
	data = JSON.parse_string(data)
	return data

func save_data(data):
	var json_string = JSON.stringify(data)
	var file = FileAccess.open(file_path, FileAccess.WRITE)
	file.store_line(json_string)
	file.close()
	
func reduce_inv_qty(item):
	var temp_item_qty = item.qty
	var temp_data_qty = item.qty
	var inv_manager = InventoryItems.new()
	var data = inv_manager.load_all_data()
	
	for i in data.size():
		if data[i].name == item.name:
			temp_item_qty = abs(data[i].qty - temp_item_qty)
			temp_data_qty = data[i].qty - temp_item_qty
			if temp_data_qty >= 0:
				data[i].qty = temp_item_qty
				break
			else:
				data[i].qty = 0
	inv_manager.save_items(data)
	
func update_status(item, status: String):
	var data = get_all_data()
	for d in data:
		if d.id == item.pid and d.name == item.pname and d.type == item.ptype:
			d.status = status
			save_data(data)
			return true
	return false
