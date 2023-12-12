extends AnimatedSprite2D

var sprite_direction = "_down": set = set_sprite_direction
var sprite_action = "idle": set = set_sprite_action

func play_animation():
	play(sprite_action + sprite_direction)

func set_sprite_direction(val):
	sprite_direction = val
	play_animation()

func set_sprite_action(val):
	sprite_action = val
	play_animation()

# Convert vector to get player direction
func _on_player_change_direction(vector):
	var vector_to_angle = (round(rad_to_deg(vector.angle()))/90)*90
	sprite_direction = Autoload.angle_to_text(vector_to_angle)

func _on_player_change_velocity(velocity_length):
	if velocity_length > 0:
		sprite_action = "walk"
	else:
		sprite_action = "idle"

func _on_player_change_attack(body):
	Autoload.is_attacking = true
	sprite_action = "attack"

func _on_animation_finished():
	if sprite_action == "attack":
		Autoload.is_attacking = false
		sprite_action = "idle"
