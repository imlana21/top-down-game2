extends CharacterBody2D

var item_list = ["leather", "ore", "rare_ore", "raw_meat", "tomato", "wheat", "wood"]
var is_gold = false
var is_player_left = false
var is_item_left = false

func _ready():
	set_collision_layer_value(5, false)
	_spawn_item()

func _spawn_item():
	var item_name = item_list[randi_range(0, item_list.size() - 1)]
	var item_scene = load("res://scene/other/items/" + item_name + "/" + item_name + ".tscn").instantiate()
	item_scene.position = position
	get_parent().add_child(item_scene)
	if is_gold:
		$TextureRect.modulate = "CFB53B"
		item_scene.modulate = "CFB53B"
		item_scene.set_item_qty(5)
	# print("Gold")
	# print(item_scene.get_item_detail())
	# print("Item spawned on ", item_scene.get_global_position())

func _on_light_square_area_body_exited(body):
	if body.is_in_group("player"):
		is_player_left = true
	if body.is_in_group("items"):
		is_item_left = true
	if is_item_left and is_player_left:
		set_collision_layer_value(5, true)
