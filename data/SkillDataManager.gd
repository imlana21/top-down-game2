class_name SkillDataManager
extends Node

var file_path: String = "res://data/json/skill_tree.json"

func get_all_items():
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

func update_status(item, status: bool):
	var data = get_all_items()
	for i in data.size():
		if data[i].id == item.id:
			data[i].active = status
			save_items(data)
			return true
	return false