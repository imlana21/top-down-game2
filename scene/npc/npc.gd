class_name NPC
extends CharacterBody2D
	
var move_state: bool = false
var move_direction: Vector2 = Vector2.ZERO

func random_move():
	var move: Vector2 = Vector2.ZERO
	match randi_range(0, 7):
		1:
			move = Vector2(1, 0)
		2:
			move = Vector2(-1, 0)
		3:
			move = Vector2(0, 1)
		4:
			move = Vector2(0, -1)
		_:
			move = Vector2(0, 0)
			
	return move
