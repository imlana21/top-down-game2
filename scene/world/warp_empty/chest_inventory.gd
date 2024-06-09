extends Inventory

const inv_name = "warp_chest"

func _ready():
	inventory_name = inv_name
	_init_slot_id($ScrollContainer/PanelContainer)

func init_inventory():
	set_inventory($ScrollContainer/PanelContainer)