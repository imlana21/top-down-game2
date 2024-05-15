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
	
func delete_item(item_id):
	var data = get_all_items()
	for i in data.size():
		if data[i].id == item_id:
			data.remove_at(i)
			save_items(data)
			return true
	return false
	
func refresh_item(item_id):
	var data = get_all_items()
	data.append({
		"id": item_id,
		"required_item": _generate_req_items(),
		"rewards": _generate_rewards(),
		"status": false,
		"from": _generate_from()
	})
	save_items(data)

func _generate_req_items():
	return [{
			"name": "wheat",
			"qty": randi_range(0, 15)
		}, {
			"name": "tomato",
			"qty": randi_range(0, 15)
		}, {
			"name": "wood",
			"qty": randi_range(0, 15)
		}, {
			"name": "leather",
			"qty": randi_range(0, 15)
		}, {
			"name": "meat",
			"qty": randi_range(0, 15)
		},
	]

func _generate_rewards():
	return {
		"coin": randi_range(0, 1000),
		"exp": randi_range(100, 700),
		"gem": randi_range(1, 6)
	}
	
func _generate_from():
	var req_list = ["Kinder Garden", "Shoe Store", "Hana Boutique", "Lumine Store", "Coffee Shop", "Hartono Mall", "Raiden Garage"]
	
	return req_list.pick_random()
