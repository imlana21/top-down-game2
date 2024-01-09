extends CanvasLayer

func _input(event):
	if Input.is_action_just_pressed("change_skin"):
		$SkinMenu.visible = !$SkinMenu.visible 
		$SkinMenu.z_index = 10
		$SkinMenu.scale = Autoload.pause_scale
		$SkinMenu.position = Autoload.pause_position
		Autoload.toggle_pause()
