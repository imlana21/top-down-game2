extends CanvasLayer

func _input(_event):
	if Input.is_action_just_pressed("change_skin") and !CombatDetail.is_attacking:
		if Autoload.paused_on == "" or Autoload.paused_on == "change_skin":
			$SkinMenu.visible = !$SkinMenu.visible 
			$SkinMenu.z_index = 10
			$SkinMenu.scale = Autoload.pause_scale
			$SkinMenu.position = Autoload.pause_position
			Autoload.toggle_pause("change_skin")
