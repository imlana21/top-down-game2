extends CanvasLayer

func _input(_event):
	if Input.is_action_just_pressed("tab_menu") and !CombatDetail.is_attacking:
		if Autoload.paused_on == "" or Autoload.paused_on == "tab_menu":
			$TabMenu.visible = !$TabMenu.visible 
			$TabMenu.z_index = 10
			$TabMenu.scale = Autoload.pause_scale
			$TabMenu.position = Autoload.pause_position
			Autoload.toggle_pause("tab_menu")
	
func _physics_process(delta):
	if Autoload.player != null and (Autoload.paused_on == "" or Autoload.paused_on == "tab_menu"):
		$TabMenu.global_position = Autoload.player.global_position
