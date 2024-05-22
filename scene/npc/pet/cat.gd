extends CharacterBody2D

@export var follow_speed: int = 200
@export var pet_name: String = 'Cat'
@export var CHAR_DETAIL: Dictionary = {
	'max_hp': 20,
	'curr_hp': 20,
	'atk_speed': 0.6,
	'luk': 0.5,
	'def': 1,
	'str': 1,
	'exp': 0,
	'level': 1,
	'bond': 1
}

func _ready():
	$Sprite.play('idle')

func walk() -> void:
	pass

func follow_player() -> void:
	pass

func set_animations() -> void:
	pass

func attacking() -> void:
	pass

func take_damage() -> void:
	pass

func set_curr_hp(val):
	CHAR_DETAIL.curr_hp = val

func set_up_exp(val):
	CHAR_DETAIL.exp += val

func set_up_level(val):
	CHAR_DETAIL.level += val

func set_up_bond(val):
	CHAR_DETAIL.bond += val

func set_stats(
	max_hp: int =0,
	atk_speed: float =0.0,
	luk: float =0.0,
	def: int =0,
	strength: int =0
):
	CHAR_DETAIL.max_hp = max_hp
	CHAR_DETAIL.atk_speed = atk_speed
	CHAR_DETAIL.luk = luk
	CHAR_DETAIL.def = def
	CHAR_DETAIL.str = strength