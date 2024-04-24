extends CanvasLayer
	
func _physics_process(delta):
	if Autoload.machine_inventory and !$MachineGui.visible and Autoload.paused_on == "":
			$MachineGui.visible = true
			$MachineGui.z_index = 10
			$MachineGui.scale = Vector2(1, 1)
			$MachineGui.position = Autoload.pause_position
			$MachineGui.reset_gui()
			$MachineGui.init_gui()
			Autoload.toggle_pause("machine_inv")
	if Autoload.player and Autoload.paused_on == "machine_inv":
		$MachineGui.global_position = Autoload.player.global_position

func _on_machine_gui_close_window():
	if Autoload.machine_inventory and $MachineGui.visible and Autoload.paused_on == "machine_inv":
		Autoload.machine_inventory = null
		$MachineGui.visible = false
		$MachineGui.z_index = 0
		$MachineGui.scale = Vector2(1, 1)
		$MachineGui.position = Autoload.pause_position
		Autoload.toggle_pause("machine_inv")


func _on_machine_gui_craft_success():
	_on_machine_gui_close_window()
