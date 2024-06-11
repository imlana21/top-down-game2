extends CharacterBody2D

@export var SPEED: int = 10

var player_body: CharacterBody2D
var conveyor_direction: int

func _ready():
	$Sprite.play('left')

func _process(delta):
	if player_body:
		move_player(delta)

func _on_area_body_entered(body:CharacterBody2D) -> void:
	player_body = body
	conveyor_direction = round(rotation_degrees)

func _on_area_body_exited(body:CharacterBody2D) -> void:
	player_body = null
	conveyor_direction = 0
	
func move_player(delta: float) -> void:
	var player_position = Vector2.ZERO
	if conveyor_direction == 0:
		# left
		player_position = Vector2(-1, 0)
	elif conveyor_direction == -180:
		# right
		player_position = Vector2(1, 0)	
	elif conveyor_direction == 90:
		# up
		player_position = Vector2(0, -1)
	elif conveyor_direction == 270 or conveyor_direction == -90:
		# down
		player_position = Vector2(0, 1)
	var player_direction = player_position * SPEED * delta
	player_body.position += player_direction
	# move_and_slide()
	print(player_direction)