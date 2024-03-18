extends Inventory

const inv_name = "chest"

func _ready():
	inventory_name = inv_name
	_init_slot_id($Container)
	
func _input(_event):
	if Input.is_action_just_released("pick_item"):
		set_inventory($Container)

func _on_chest_store_inventory_updated():
	set_inventory($Container)
