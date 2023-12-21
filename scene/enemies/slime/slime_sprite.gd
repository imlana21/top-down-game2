extends AnimatedSprite2D

var sprite_action = "idle": set = set_sprite_action

func _ready():
	sprite_action = "idle"

func play_animation():
	if CombatDetail.is_attacking:
		play(sprite_action)
		flip_h = true
	else:
		play("idle")
		flip_h = false
		
func set_sprite_action(val):
	sprite_action = val
	play_animation()
	
func _on_slime_change_attack():
	sprite_action = "attack"

func _on_animation_finished():
	sprite_action = "idle"
