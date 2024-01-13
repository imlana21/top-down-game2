extends CanvasLayer

var is_content_show: bool = false

func _input(_event):
	if Input.is_action_just_pressed("inventory") and !CombatDetail.is_attacking:
		$Inventory.visible = !$Inventory.visible 
		$Inventory.z_index = 10
		$Inventory.scale = Autoload.pause_scale
		$Inventory.position = Autoload.pause_position
		Autoload.toggle_pause()
