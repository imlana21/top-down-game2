extends CanvasLayer
	
func _physics_process(delta):
	if Autoload.machine_inventory and !$MachineGui.visible and Autoload.paused_on == "":
		$MachineGui.remove_gui()
		$MachineGui.show_gui()
		Autoload.toggle_pause("machine_inv")
	if Autoload.player and Autoload.paused_on == "machine_inv":
		$MachineGui.global_position = Autoload.player.global_position

func _on_machine_gui_close_window():
	if Autoload.machine_inventory and $MachineGui.visible and Autoload.paused_on == "machine_inv":
		Autoload.machine_inventory = null
		$MachineGui.remove_gui()
		Autoload.toggle_pause("machine_inv")

func _on_machine_gui_craft_success():
	_on_machine_gui_close_window()
