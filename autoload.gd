extends Node

var player_skin = "normal"
var is_attacking: bool = false
var is_paused: bool = false
var player: CharacterBody2D
var world: Node2D
var scene_manager: Node2D
var pause_scale: Vector2
var pause_position: Vector2
var enemy_position: Array = [
	Vector2(64, 256), 
	Vector2(352, 288), 
	Vector2(512, 100),
	Vector2(384, 500),
	Vector2(256, 512)
]
var enemy_list: Array
var enter_world_position: Dictionary = {
	"WorldToLivingRoom": Vector2(0,0),
	"LivingRoomToWorld": Vector2(55, -45),
	"LivingRoomToKitchen": Vector2(0,0),
	"KitchenToLivingRoom": Vector2(160, -78)	
}
	
# Toggle Pause Game
func toggle_pause():
	is_paused = !is_paused
	get_tree().paused = is_paused

func pause_game(body):
	toggle_pause()
	if is_paused:
		body.show()
	else:
		body.hide()

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

func spawn_enemy(rooms, pos):
	var enemy_instance = load("res://scene/enemies/slime/slime.tscn").instantiate()
	enemy_instance.position = pos
	enemy_instance.name = enemy_instance.name + str(pos.x) + "_" + str(pos.y)
	enemy_list.append(enemy_instance.name)
	rooms.add_child(enemy_instance)
