extends CanvasLayer

func _input(_event):
	if Input.is_action_just_pressed("tab_menu") and !CombatDetail.is_attacking:
		if Autoload.paused_on == "" or Autoload.paused_on == "tab_menu":
			$TabMenu.visible = !$TabMenu.visible 
			$TabMenu.z_index = 10
			$TabMenu.scale = Autoload.pause_scale
			$TabMenu.reset_zoom()
			Autoload.toggle_pause("tab_menu", $TabMenu)