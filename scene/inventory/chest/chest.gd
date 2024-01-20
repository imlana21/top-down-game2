extends CharacterBody2D

signal player_near_chest

func _init():
	Autoload.chest_store = self
	
func _on_chest_area_body_entered(body):
	player_near_chest.emit(true)

func _on_chest_area_body_exited(body):
	player_near_chest.emit(false)
