class_name SaveLoad
extends Node

const SAVE_DIR = "res://data/saves/"
const SAVES_FILE_NAME = "save"
const SECURITY_CODE = "HESOYAM"

func verify_save_dir(path: String):
	DirAccess.make_dir_absolute(path)
	
func save_data():
	var path = SAVE_DIR + SAVES_FILE_NAME
	var file = FileAccess.open_encrypted_with_pass(path, FileAccess.WRITE, SECURITY_CODE)
	print(file)
	if file == null:
		print(FileAccess.get_open_error())
		return false
	var inventory = InventoryItems.new()
	var player_data = {
		"player": Autoload.player.CHAR_DETAIL,
		"world":{
			"player_pos": {
				"x": Autoload.player.get_global_position().x,
				"y": Autoload.player.get_global_position().y
			},
			"world_path": Autoload.world.scene_file_path,			
		},
		"inventory": inventory.load_all_data()
	}
	player_data = JSON.stringify(player_data)
	file.store_string(player_data)
	print("Saved on ", path)
	file.close()
	return true

func load_data(): 
	var path = SAVE_DIR + SAVES_FILE_NAME
	var inventory = InventoryItems.new()
	if FileAccess.file_exists(path):
		var file = FileAccess.open_encrypted_with_pass(path, FileAccess.READ, SECURITY_CODE)
		if file == null:
			print(FileAccess.get_open_error())
			return
		var content = file.get_as_text()
		file.close()
		print("Load Success")
		
		var data = JSON.parse_string(content)
		if data == null:
			printerr("Cannot parse %s as json_string: (%s)" %[path, content])
			return
		Autoload.player.CHAR_DETAIL = data.player
		load_to_inventory(data.inventory)
		await load_world(data.world.world_path)
		Autoload.player.global_position = Vector2(data.world.player_pos.x, data.world.player_pos.y)
		return true
	printerr("Cannot open non-existent file at %s!" %[path])
	return false

func load_to_inventory(data):
	var inv = InventoryItems.new()
	inv.save_items(data)

func load_world(path: String):
	Autoload.scene_manager._on_change_scene(path, Autoload.world)
	
func new_game(curr_world: Node2D):
	var inv = InventoryItems.new()
	var next_path = 'res://scene/world/world.tscn'
	Autoload.scene_manager._on_change_scene(next_path, curr_world)
	Autoload.player.CHAR_DETAIL = {
		"atk_speed": 0.6,
		"max_hp": 50,
		"curr_hp": 50,
		"luk": 0.5,
		"def": 1,
		"str": 3,
		"exp": 0,
		"level": 1
	}
	inv.save_items([])
