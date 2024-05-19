class_name LevelDataManager
extends Node

var file_path: String = "res://data/json/reward_level.json"

func get_all_level():
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

func claim_reward(level, status: bool):
	var data = get_all_level()
	for i in data.size():
		if data[i].level == level:
			data[i].active = status
			save_items(data)
			return true
	return false

func laod_level(level):
	var data = get_all_level()
	for i in data.size():
		if data[i].level == level:
			return data[i]
	return null

