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
	update_stats(AutoloadPet.set_node(self))
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

func _on_sprite_animation_finished():
		$Sprite.play('idle')	

func attacking():
	if !Autoload.prevent_attack:
		$Sprite.play('jump')

func take_damage(strength):
	CHAR_DETAIL["curr_hp"] = CHAR_DETAIL["curr_hp"] - strength

func update_stats(val):
	if val == null: return
	CHAR_DETAIL = val

func _on_mouse_entered():
	AutoloadPet.mouse_on_pet = true

func _on_mouse_exited():
	AutoloadPet.mouse_on_pet = false
