extends CanvasLayer

func _input(event):
	if Input.is_action_just_pressed("pause"):
		$Pause.visible = !$Pause.visible 
		$Pause.z_index = 10
		$Pause.scale = Autoload.pause_scale
		$Pause.position = Autoload.pause_position
		Autoload.toggle_pause()
