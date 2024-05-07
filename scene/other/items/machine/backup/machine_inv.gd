extends Inventory

@onready var inv_slot_container: GridContainer = $ScrollContainer/GridContainer
@onready var crafting_panel: Panel = null

# Called when the node enters the scene tree for the first time.
func _ready():
	for inv in inv_slot_container.get_children():
		inv.connect("inv_panel_clicked", _inv_panel_clicked)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _inv_panel_clicked(panel):
	if crafting_panel != null:
		crafting_panel.set_item(panel.item.data)

func inv_init(craft_panel):
	crafting_panel = craft_panel
	inventory_name = "player"
	_init_slot_id(inv_slot_container)
	set_inventory(inv_slot_container, "player")
