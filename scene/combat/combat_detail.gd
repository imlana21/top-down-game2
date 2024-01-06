extends Node

var enemy_type: String = "normal"
var enemy_detail: Dictionary
var status_boss:String = "alive"
var player_detail: Dictionary
var is_attacking: bool = false
var last_position = null
var battle_speed: float = 1.0
var player_energy: int = 3
var exp_max: int = 1000
var coin: int = 0
var gem: int = 0
var coin_position: Array = []

func set_player_detail(val):
	player_detail = val

func set_is_attacking(val):
	is_attacking = val

func get_battle_speed(normal_speed: float):
	return normal_speed / CombatDetail.battle_speed

func set_exp_max():
	if player_detail["level"] == 1:
		exp_max = 1000
	else:
		exp_max = round(1.11 * exp_max)

func level():
	while player_detail["exp"] > exp_max:
		player_detail["exp"] -= exp_max
		player_detail["level"] += 1
		set_exp_max()
		
func spawn_coin(world, pos, status):
	var coin_intance = load("res://scene/enemies/currencies/coins/coin.tscn").instantiate()
	if status != "bos":
		coin_intance.scale = Vector2(0.5, 0.5)
	coin_intance.position = pos
	coin_intance.enemy_status = status
	world.add_child(coin_intance)
	
