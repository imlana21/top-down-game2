extends Node2D

signal start_combat

func _process(delta):
	# Move Camera position to follow user
	$Camera2D.position = $Player.position

func _on_player_start_combat(enemy):
	start_combat.emit(enemy)
