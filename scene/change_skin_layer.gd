extends CanvasLayer

func _input(_event):
	if Input.is_action_just_pressed("change_skin") and !CombatDetail.is_attacking:
		$SkinMenu.visible = !$SkinMenu.visible 
		$SkinMenu.z_index = 10
		$SkinMenu.scale = Autoload.pause_scale
		$SkinMenu.position = Autoload.pause_position
		Autoload.toggle_pause()
