extends InventorySlot

func _ready():
	refresh_style()
	inventory_name = get_parent().get_parent().inv_name
	parent_name = "ChestStore"
	connect("gui_input", _on_gui_input)
	connect("mouse_exited", _on_mouse_exited)
	connect("mouse_entered", _on_mouse_entered)