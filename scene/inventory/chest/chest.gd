extends CharacterBody2D

func _on_chest_area_body_entered(body):
	Autoload.chest_store = self

func _on_chest_area_body_exited(body):
	Autoload.chest_store = null
