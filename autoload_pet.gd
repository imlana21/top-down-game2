extends Node

var pet_detail = null
var pet_node = null : set = set_node
var pet_exp_max: int = 20
var mouse_on_pet: bool = false

func set_node(node: CharacterBody2D): 
	if pet_detail == null:
		pet_node = node
		pet_detail = node.CHAR_DETAIL
		return null
	return pet_detail

func level_up(enemy_exp: int) -> void:
	if pet_detail:
		pet_detail.exp += round(enemy_exp / 2)
		while pet_detail.exp >= pet_exp_max:
			pet_detail.exp -= pet_exp_max
			pet_detail.level += 1
			set_pet_exp_max()
			upgrade_stats()

func set_pet_exp_max():
	if pet_detail.level == 1:
		pet_exp_max = 100
	else:
		pet_exp_max = round(1.13 * pet_exp_max)

func upgrade_stats():
		pet_detail.max_hp = pet_detail.max_hp * 1.3
		pet_detail.curr_hp = pet_detail.max_hp
		pet_detail.atk_speed = pet_detail.atk_speed * 1.1
		pet_detail.luk = pet_detail.luk * 1.02
		pet_detail.def = pet_detail.def * 1.2
		pet_detail.str = pet_detail.str * 1.3