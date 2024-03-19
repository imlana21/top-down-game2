extends InventorySlot

func _ready():
	refresh_style() 
	parent_name = "BuilderInv"
	inventory = InventoryItems.new()
	inventory_name = "builder"
	connect("gui_input", _on_gui_input)
	connect("mouse_exited", _on_mouse_exited)
	connect("mouse_entered", _on_mouse_entered)
