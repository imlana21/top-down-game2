extends Node

var player_detail: Dictionary
var is_attacking: bool = false
var last_position = null
var is_enemy_boss:bool = false
var enemy_detail: Dictionary
var is_boss_killed:bool = false
var battle_speed: float = 1.0
var player_energy: int = 3
var exp_max: int = 1000: set = set_exp_max

func set_player_detail(val):
	player_detail = val

func set_is_attacking(val):
	is_attacking = val

func get_battle_speed(normal_speed: float):
	return normal_speed / CombatDetail.battle_speed

func set_exp_max(level: int):
	if level == 1:
		exp_max = 1000
	else:
		exp_max = round(1.11 * exp_max)

func level():
	if player_detail["exp"] > exp_max:
		player_detail["exp"] -= exp_max
		player_detail["level"] += 1
		set_exp_max(player_detail["level"])
