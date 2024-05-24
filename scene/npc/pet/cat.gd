extends CharacterBody2D

@export var follow_speed: int = 200
@export var CHAR_DETAIL: Dictionary = {
	'pet_name': 'cat',
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
var player: CharacterBody2D
var follow_distance: float = 39
var speed: int = 90

func _ready():
	Autoload.pet_detail = CHAR_DETAIL
	if !CombatDetail.is_attacking:
		player = get_parent().get_node("Player")
	$Sprite.play('idle')

func _process(delta):
	if player:
		var direction = (player.position - position).normalized()
		var distance_to_player = player.position.distance_to(position)
		if distance_to_player > follow_distance:
			velocity = direction * speed
			move_and_slide()
			play_animation(direction)
		else:
			if distance_to_player < 0:
				$Sprite.play('idle')
			velocity = Vector2.ZERO
			move_and_slide()

func _input(event):
	if event is InputEventKey and not event.is_pressed():
		play_animation(Vector2.ZERO)

func play_animation(d):
	var new_direction = Vector2(round(d.x), round(d.y))
	if new_direction == Vector2(0, 0):
		$Sprite.play('idle')
	else:
		if new_direction == Vector2(0, 1):
			$Sprite.play('walk_right')
		if new_direction == Vector2(0, -1):
			$Sprite.play('walk_right')
		if new_direction == Vector2(1, 0):
			$Sprite.flip_h = false
			$Sprite.play('walk_right')
		if new_direction == Vector2( - 1, 0):
			$Sprite.flip_h = true
			$Sprite.play('walk_right')
		
func set_curr_hp(val) -> void:
	CHAR_DETAIL.curr_hp = val

func set_up_exp(val) -> void:
	CHAR_DETAIL.exp += val

func set_up_level(val) -> void:
	CHAR_DETAIL.level += val

func set_up_bond(val) -> void:
	CHAR_DETAIL.bond += val

func set_stats(
	max_hp: int=0,
	atk_speed: float=0.0,
	luk: float=0.0,
	def: int=0,
	strength: int=0
) -> void:
	CHAR_DETAIL.max_hp = max_hp
	CHAR_DETAIL.atk_speed = atk_speed
	CHAR_DETAIL.luk = luk
	CHAR_DETAIL.def = def
	CHAR_DETAIL.str = strength

func _on_sprite_animation_finished():
		$Sprite.play('idle')	

func attacking():
	if !Autoload.prevent_attack:
		$Sprite.play('jump')

func take_damage(strength):
	CHAR_DETAIL["curr_hp"] = CHAR_DETAIL["curr_hp"] - strength