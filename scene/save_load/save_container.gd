extends MarginContainer

var save_action: String = '': set = set_save_action
var btn_text = ""
var save_path = ""
var is_from_main = false

@onready var container = $SlotContainer.get_children()
signal load_game_from_pause
		
func _ready():
	for i in container.size():
		container[i].slot_id = i + 1
		container[i].connect("load_game", _on_load_game)

func set_save_action(val):
	save_action = val
	for i in container.size():
		container[i].set_status(val)

func _on_load_game(data):
	if save_action == "load" and data != null:
		Autoload.is_load_game = true
		Autoload.load_data = data
		if is_from_main:
			get_tree().change_scene_to_file("res://scene/scene_manager.tscn")
		else:
			load_game_from_pause.emit(data, save_action)
	else:
		load_game_from_pause.emit(data, save_action)
