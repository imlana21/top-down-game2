class_name NPC
extends CharacterBody2D
	
var move_state: bool = false
var move_direction: Vector2 = Vector2.ZERO
var wait_time: float = 2.0
var move_time: float = 0.3
var move_speed: int = 10

func random_move():
	var move: Vector2 = Vector2.ZERO
	match randi_range(0, 6):
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

func move_animation(move, sprite):
	match move:
		Vector2(0, 0):
			sprite.play("idle")
		Vector2(-1, 0), Vector2(0, -1):
			sprite.flip_h = true
			sprite.play("walk")
		Vector2(1, 0), Vector2(0, 1):
			sprite.flip_h = false
			sprite.play("walk")
