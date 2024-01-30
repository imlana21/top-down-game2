class_name SaveManager
extends Node

const SAVE_DIR = "res://data/saves/"
const SECURITY_CODE = "HESOYAM"

func verify_save_dir():
	DirAccess.make_dir_absolute(SAVE_DIR)
	
func init_new_game(curr_world: Node2D):
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
	
func save_data(file_name):
	var path = SAVE_DIR + file_name
	var file = FileAccess.open_encrypted_with_pass(path, FileAccess.WRITE, SECURITY_CODE)
	verify_save_dir()
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
		"inventory": inventory.load_all_data(),
		"coin": CombatDetail.coin,
		"gem": CombatDetail.gem,
		"created_at": Time.get_date_dict_from_system(),
	}
	player_data = JSON.stringify(player_data)
	file.store_string(player_data)
	print("Saved on ", path)
	file.close()
	return true

func load_data(file_name): 
	var path = SAVE_DIR + file_name
	if FileAccess.file_exists(path):
		var file = FileAccess.open_encrypted_with_pass(path, FileAccess.READ, SECURITY_CODE)
		if file == null:
			print(FileAccess.get_open_error())
			return false
		var content = file.get_as_text()
		file.close()
		print("Load Success")
		
		var data = JSON.parse_string(content)
		if data == null:
			printerr("Cannot parse %s as json_string: (%s)" %[path, content])
			return false
		return data
	#printerr("Cannot open non-existent file at %s!" %[path])
	return false

func load_world(data):
	var inv = InventoryItems.new()
	inv.save_items(data.inventory)
	Autoload.player.CHAR_DETAIL = data.player
	Autoload.scene_manager._on_change_scene(data.world.world_path, Autoload.world)
	Autoload.player.global_position = Vector2(data.world.player_pos.x, data.world.player_pos.y)
	CombatDetail.coin = int(data.coin)
	CombatDetail.gem = int(data.gem)
	
	

