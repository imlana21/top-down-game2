extends Node

var player_detail: set = set_player_detail
var is_attacking: bool = false
var last_position = null: set = set_last_position
var is_enemy_boss:bool = false
var enemy_detail: Dictionary
var is_boss_killed:bool = false
var battle_speed: float = 1.0
var player_energy: int = 3

func set_player_detail(val):
	player_detail = val

func set_is_attacking(val):
	is_attacking = val
	
func set_last_position(val):
	last_position = val

func get_battle_speed(normal_speed: float):
	return normal_speed / CombatDetail.battle_speed
