extends CharacterBody2D

func _on_area_detector_body_entered(body):
	Autoload.bench = self


func _on_area_detector_body_exited(body):
	Autoload.bench = null
