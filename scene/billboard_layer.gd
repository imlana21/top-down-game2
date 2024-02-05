extends CanvasLayer

func _input(_event):		
	if Autoload.billboard != null:
		if Input.is_action_just_pressed("pick_item") and Autoload.billboard.is_player_near:
			if Autoload.paused_on == "" or Autoload.paused_on == "billboard":
				$BulletinBoard.visible = !$BulletinBoard.visible
				$BulletinBoard.z_index = 10
				$BulletinBoard.scale = Autoload.pause_scale
				$BulletinBoard.position = Autoload.pause_position
				Autoload.toggle_pause("billboard")

