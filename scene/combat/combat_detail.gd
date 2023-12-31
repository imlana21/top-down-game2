extends Node

var player_detail: set = set_player_detail
var enemy_detail: set = set_enemy_detail
var is_attacking = false
var last_position = null: set = set_last_position
var last_enemy = null
var player_energy = 1

func set_player_detail(val):
	player_detail = val
	
func set_enemy_detail(val):
	enemy_detail = val

func set_is_attacking(val):
	is_attacking = val
	
func set_last_position(val):
	last_position = val
