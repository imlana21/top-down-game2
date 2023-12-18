extends Node2D

func _process(delta):
	# Move Camera position to follow user
	$Camera2D.position = $Player.position
