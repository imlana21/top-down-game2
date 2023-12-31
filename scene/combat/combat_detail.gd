extends Node

@export var player_energy = 1

var player_detail: set = set_player_detail
var is_attacking: bool = false
var last_position = null: set = set_last_position
var is_enemy_boss:bool = false
var enemy_detail: Dictionary
var is_boss_killed:bool = false

func set_player_detail(val):
	player_detail = val

func set_is_attacking(val):
	is_attacking = val
	
func set_last_position(val):
	last_position = val
