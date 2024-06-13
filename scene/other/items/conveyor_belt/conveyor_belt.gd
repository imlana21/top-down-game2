extends CharacterBody2D

@export var SPEED: int = 10

var player_body: Array
var conveyor_direction: int

func _ready():
	$Sprite.play('left')

func _process(delta):
	if player_body.size() > 0:
		for p in player_body:
			if p.move_state:
				move_player(p, delta)
		# else:
func _on_area_body_entered(body:CharacterBody2D) -> void:
	if body:
		player_body.append(body)
		conveyor_direction = round(rotation_degrees)

func _on_area_body_exited(body:CharacterBody2D) -> void:
	if body:
		body.move_state = false		
		await get_tree().create_timer(0.5).timeout
		body.move_state = true
		conveyor_direction = 0
		var index = player_body.find(body)
		player_body.remove_at(index)
	
func move_player(body, delta: float) -> void:
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
	body.position += player_direction
	print(player_direction)
	# move_and_slide()