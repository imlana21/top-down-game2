extends Node

var player_detail: set = set_player_detail
var enemy_detail: set = set_enemy_detail
var is_attacking = false

func set_player_detail(val):
	player_detail = val
	
func set_enemy_detail(val):
	enemy_detail = val

func set_is_attacking(val):
	is_attacking = val