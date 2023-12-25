extends Node2D

signal start_combat

func _on_wait_time_timeout():
	start_combat.emit()
	queue_free()
