extends Node

var player_skin: String = "normal"
var pause_content = null
var paused_on: String = ""
var player: CharacterBody2D
var world: Node2D
var scene_manager: Node2D
var pause_scale: Vector2
var pause_position: Vector2
var prevent_attack: bool = false
var enemy_position: Array = [
	Vector2(64, 256), 
	Vector2(352, 288), 
	Vector2(512, 100),
	Vector2(384, 500),
	Vector2(256, 512)
]
var enemy_list: Array
var red_enemy_position: Array = [
	Vector2(128, 384), 
	Vector2(704, 320), 
	Vector2(832, 448)
]
var red_enemy_list: Array = []
var red_coin_position: Array = []
var enter_world_position: Dictionary = {
	"WorldToLivingRoom": Vector2(0,0),
	"WorldToCave": Vector2(0,0),
	"LivingRoomToWorld": Vector2(55, -45),
	"LivingRoomToKitchen": Vector2(0,0),
	"KitchenToLivingRoom": Vector2(160, -78),
	"CaveToWorld": Vector2(680, -68),
	"CaveToFloor2": Vector2(0,0),
	"CaveToFloor1": Vector2(-116, -476),
	"CaveToRandomRoom1": Vector2(0,0),
	"CaveToRandomRoom2": Vector2(0,0),
	"CaveToRandomRoom3": Vector2(0,0),
	"CaveToRandomRoom4": Vector2(0,0),
	"CaveToRandomRoom5": Vector2(0,0),
	"CaveToRandomRoom6": Vector2(0,0),
	"CaveToRandomRoom7": Vector2(0,0),
	"CaveToRandomRoom8": Vector2(0,0),
	"CaveToRandomRoom9": Vector2(0,0),
	"CaveToRandomRoom10": Vector2(0,0),
	"OutFromRoom": Vector2(-2, -530)
}
var chest_store: CharacterBody2D
var player_inventory: Node2D
var tree_position: Array = []
var ore_position_1: Array = [
	Vector2(375, 263),
	Vector2(473, 263),
	Vector2(431, 275),
	Vector2(463, 293),
	Vector2(467, 328),
	Vector2(433, 310),
	Vector2(397, 291),
	Vector2(395, 263)
]
var ore_name_1: Array = []
var ore_position_2: Array = [
	Vector2(375, 263),
	Vector2(473, 263),
	Vector2(431, 275),
	Vector2(467, 328),
	Vector2(395, 263)
]
var ore_name_2: Array = []
var rare_ore_position: Array = []
var rare_ore_name: Array = []
var is_load_game: bool = false
var load_data = null
var leather_position: Array
var meat_position: Array
var billboard: CharacterBody2D
var bench: CharacterBody2D
var is_spectator_mode: bool = false
var teleport_room: Array
var teleported_room: Array
var cheat_mode: bool = false
var warpworld_enemy_killed = false
var machine_inventory: CharacterBody2D
var pet_detail: Dictionary

func reset_teleport_room():
	teleported_room = []
	teleport_room = []
	for i in range(0, 10):
		teleport_room.append(i + 1)
		
# Toggle Pause Game
func toggle_pause(layer, content = null):
	if paused_on == "":
		pause_content = content
		paused_on = layer
		get_tree().paused = true
	else: 
		pause_content = content
		paused_on = ""
		get_tree().paused = false

# Convet mouse position to deg
func deg_mouse_position(body):
	var mouse_position = body.get_global_mouse_position()
	var angle_to_mouse = atan2(mouse_position.y - body.global_position.y, mouse_position.x - body.global_position.x)
	return rad_to_deg(angle_to_mouse)

# Convert Angle to direction
func angle_to_text(angle):
	match angle:
		-90.0, -45.0, -135.0:
			return "up"
		0.0:
			return "right"
		180.0:
			return "left"
		45.0, 90.0, 135.0:
			return "down"

# Generate Random Position
func random_position():
	randomize()
	var spawn_x = randi_range(0, 1000)
	var spawn_y = randi_range(30, 500)
	return Vector2(spawn_x, spawn_y)

# Generate Enemy
func spawn_enemy(rooms, pos, type = ""):
	var enemy_instance = load("res://scene/enemies/slime/slime.tscn").instantiate()
	enemy_instance.position = pos
	enemy_instance.name = enemy_instance.name + str(pos.x) + "_" + str(pos.y)
	enemy_instance.type = type
	if type == "normal":
		enemy_list.append(enemy_instance.name)
	if type == "red":
		enemy_instance.modulate = "ff0000"
		red_enemy_list.append(enemy_instance.name)
	rooms.add_child(enemy_instance)
	
func spawn_tree(rooms, pos):
	var object_instance = load("res://scene/other/object/tree/tree.tscn").instantiate()
	object_instance.position = pos
	object_instance.name = object_instance.name + str(pos.x) + "_" + str(pos.y)
	rooms.add_child(object_instance)
	
func spawn_ore(rooms, pos, cave_floor):
	var object_instance = load("res://scene/other/object/ore/ore.tscn").instantiate()
	object_instance.position = pos
	object_instance.name = object_instance.name + str(pos.x) + "_" + str(pos.y)
	if cave_floor == 1:
		ore_name_1.append(object_instance.name)
	elif cave_floor == 2:
		ore_name_2.append(object_instance.name)
	rooms.add_child(object_instance)
	
func spawn_rare_ore(rooms, pos):
	var object_instance = load("res://scene/other/object/rare_ore/rare_ore.tscn").instantiate()
	object_instance.position = pos
	object_instance.name = object_instance.name + str(pos.x) + "_" + str(pos.y)
	object_instance.scale = Vector2(0.7, 0.7)
	rare_ore_name.append(object_instance.name)
	print("Rare Ore Spawn on ", pos)
	rooms.add_child(object_instance)



