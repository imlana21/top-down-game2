extends CanvasLayer

var is_content_show: bool = false

func _input(_event):
	if Input.is_action_just_pressed("inventory")and !CombatDetail.is_attacking:
		if Autoload.paused_on == "" or Autoload.paused_on == "inventory" or Autoload.paused_on == "craft":
			if Autoload.bench == null:
				$Pockets.visible = !$Pockets.visible 
				$Pockets.z_index = 10
				$Pockets.scale = Autoload.pause_scale
				$Pockets.position = Autoload.pause_position
				Autoload.toggle_pause("inventory")
			else:
				$Crafting.visible = !$Crafting.visible 
				$Crafting.z_index = 10
				$Crafting.scale = Autoload.pause_scale
				$Crafting.position = Autoload.pause_position
				Autoload.toggle_pause("craft")
