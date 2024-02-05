class_name BulletinDataManager
extends Node

var file_path: String = "res://data/json/bulletin_board.json"

func get_all_items():
	if !FileAccess.file_exists(file_path):
		print("File not found")
		return
	var data = FileAccess.get_file_as_string(file_path)
	data = JSON.parse_string(data)
	return data

func deliver_items(item):
	var temp_item_qty = item.qty
	var temp_data_qty = item.qty
	var inv_data = InventoryItems.new()
	var data = inv_data.load_all_data()
	
	for i in data.size():
		if data[i].name == item.name:
			temp_item_qty = abs(data[i].qty - temp_item_qty)
			temp_data_qty = data[i].qty - temp_item_qty
			if temp_data_qty >= 0:
				data[i].qty = temp_item_qty
				break
			else:
				data[i].qty = 0
	inv_data.save_items(data)
	
func save_items(data):
	var json_string = JSON.stringify(data)
	var file = FileAccess.open(file_path, FileAccess.WRITE)
	file.store_line(json_string)
	file.close()
	
func item_delivered(item):
	var data = get_all_items()
	for d in data:
		if d.id == item.id_item:
			d.status = true
	save_items(data)
	
