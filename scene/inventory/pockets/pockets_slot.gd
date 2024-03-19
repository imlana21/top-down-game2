extends InventorySlot

func _ready():
	refresh_style() 
	parent_name = "Pockets"
	inventory = InventoryItems.new()
	connect("mouse_entered", _on_mouse_entered)
	connect("mouse_exited", _on_mouse_exited)
	connect("gui_input", _on_gui_input)
