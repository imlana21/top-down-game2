extends AnimatedSprite2D

var sprite_direction = "down": set = set_sprite_direction
var sprite_action = "idle": set = set_sprite_action

signal player_move 
signal player_idle

func _ready():
	if CombatDetail.is_attacking:
		play("idle_right")
		
# Convert vector to get player direction
func _on_player_change_direction(vector):
	var vector_to_angle = (round(rad_to_deg(vector.angle()))/90)*90
	sprite_direction = Autoload.angle_to_text(vector_to_angle)

func _on_player_change_velocity(velocity_length):
	if velocity_length > 0:
		sprite_action = "walk"
		player_move.emit()
	else:
		sprite_action = "idle"
		player_idle.emit()

func _on_player_change_attack():
	sprite_action = "attack"
	
func _on_animation_finished():
	sprite_action = "idle"

func play_animation():
	if CombatDetail.is_attacking:
		play(sprite_action + "_" + "right")
	else:
		play(sprite_action + "_" + sprite_direction)

func set_sprite_direction(val):
	sprite_direction = val
	play_animation()

func set_sprite_action(val):
	sprite_action = val
	play_animation()
