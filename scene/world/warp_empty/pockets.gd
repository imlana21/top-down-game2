extends Inventory

const inv_name = "player"


func _ready():
	inventory_name = inv_name
	_init_slot_id($ScrollContainer/GridContainer)

func init_inventory():
	set_inventory($ScrollContainer/GridContainer)