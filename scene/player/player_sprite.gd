extends AnimatedSprite2D

var sprite_direction = "down": set = set_sprite_direction
var sprite_action = "idle": set = set_sprite_action
var animation_speed = 1.0
var hit_object = false

func _ready():
	if CombatDetail.is_attacking:
		play("idle_right")

func _physics_process(_delta):
	if Input.is_action_pressed("run"):
		animation_speed = 2.0
	elif Input.is_action_just_pressed("attack") and !CombatDetail.is_attacking:
		hit_object = true
	else:
		animation_speed = 1.0

func _on_player_hit():
	sprite_action = "attack"
		
# Convert vector to get po0ayer direction
func _on_player_change_direction(vector):
	var vector_to_angle = (round(rad_to_deg(vector.angle()))/90)*90
	sprite_direction = Autoload.angle_to_text(vector_to_angle)

func _on_player_change_velocity(velocity_length):
	if hit_object:
		sprite_action = "attack"
	else:
		if velocity_length > 0:
			sprite_action = "walk"
		else:
			sprite_action = "idle"
	
func _on_animation_finished():
	hit_object = false
	sprite_action = "idle"

func set_sprite_direction(val):
	sprite_direction = val
	play_animation()

func set_sprite_action(val):
	sprite_action = val
	play_animation()

func play_animation():
	if CombatDetail.is_attacking:
		play(sprite_action + "_" + "right", CombatDetail.battle_speed)
	else:
		play(sprite_action + "_" + sprite_direction, animation_speed)
