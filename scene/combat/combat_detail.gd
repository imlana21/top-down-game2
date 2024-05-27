extends Node

var enemy_type: String = "normal"
var enemy_detail: Dictionary
var status_boss: String = "alive"
var player_detail: Dictionary
var is_attacking: bool = false
var last_position = null
var battle_speed: float = 1.0
var player_energy: int = 20
var exp_max: int = 100
var coin: int = 0
var gem: int = 0
var coin_position: Array = []
var wheat_position: Array = []
var tomato_position: Array = []
var silver_key_position: Array = []
var chance: bool = false
var first_init_level: bool = true
var level_popup: Control = null

func set_player_detail(val):
	player_detail = val

func set_enemy_detail(val):
	enemy_detail = val

func set_is_attacking(val):
	is_attacking = val

func get_battle_speed(normal_speed: float):
	return normal_speed / CombatDetail.battle_speed

func set_exp_max():
	if player_detail.level == 1:
		exp_max = 100
	else:
		exp_max = round(1.13 * exp_max)

func level_up():
	while player_detail.exp >= exp_max:
		player_detail.exp -= exp_max
		player_detail.level += 1
		set_exp_max()
		if level_popup and player_detail.level > 1:
			level_popup.init_level_popup(CombatDetail.player_detail.level)

func spawn_coin(world, pos, status):
	var coin_instance = load("res://scene/other/currencies/coins/coin.tscn").instantiate()
	if status != "bos":
		coin_instance.scale = Vector2(0.5, 0.5)
	coin_instance.position = pos
	coin_instance.enemy_status = status
	world.add_child(coin_instance)

func spawn_tomato(world, pos, status):
	var tomato_instance = load("res://scene/other/items/tomato/tomato.tscn").instantiate()
	if status != "bos":
		tomato_instance.scale = Vector2(0.5, 0.5)
	tomato_instance.position = pos
	tomato_instance.enemy_status = status
	world.add_child(tomato_instance)

func spawn_wheat(world, pos, status):
	var wheat_instance = load("res://scene/other/items/wheat/wheat.tscn").instantiate()
	if status != "bos":
		wheat_instance.scale = Vector2(0.5, 0.5)
	wheat_instance.position = pos
	wheat_instance.enemy_status = status
	world.add_child(wheat_instance)

func spawn_silver_key(world, pos, status):
	var key_instance = load("res://scene/other/items/key/silver_key.tscn").instantiate()
	if status != "bos":
		key_instance.scale = Vector2(0.5, 0.5)
	key_instance.position = pos
	key_instance.enemy_status = status
	world.add_child(key_instance)

func spawn_chance(percent: float):
	randomize()
	var random = randf_range(0, 1)
	print("Spawn chance ", random)
	if random >= percent:
		return true
	return false
