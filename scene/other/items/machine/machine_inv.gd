extends Inventory 

@onready var slot_container: GridContainer = $ScrollContainer/GridContainer

signal send_item_to_crafting

# Called when the node enters the scene tree for the first time.
func _ready():
	inventory_name = "player"
	_init_slot_id(slot_container)
	for inv in slot_container.get_children():
		inv.connect("inv_panel_clicked", _inv_panel_clicked)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _inv_panel_clicked(item):
	send_item_to_crafting.emit(item.data)

func _on_materials_inv_panel_clicked():
	set_inventory(slot_container, "player")
