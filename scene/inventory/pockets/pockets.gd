extends Inventory

const PANEL_SCRIPT: GDScript = preload("res://scene/inventory/pockets/pockets_slot.gd")
var holding_item = null
@onready var slot_container = $InventoryContainer

func _ready():
	inventory_name = "player"
	_init_slot_id(slot_container)
	Autoload.player_inventory = self
	
func _input(_event):
	if Input.is_action_just_released("inventory"):
		set_inventory(slot_container)
	if holding_item:
		holding_item.global_position = get_global_mouse_position() - Vector2(1, 1)

func _slot_input_event(slot: PANEL_SCRIPT):
	if holding_item:
		if slot.item:
			if slot.item.data.name == holding_item.data.name:
				var temp = slot.item
				var new_qty = slot.item.data.qty + holding_item.data.qty
				if new_qty <= slot.item.data.stack_size:
					slot.remove_child(slot.item)
					slot.put_into_slot(holding_item, slot.item, new_qty)
					holding_item = null
					set_inventory(slot_container)
				else:
					slot.pick_from_slot()
					temp.global_position = get_global_mouse_position()
					slot.put_into_slot(holding_item)
					holding_item = temp
			else: 
				var temp = slot.item
				slot.pick_from_slot()
				temp.global_position = get_global_mouse_position()
				slot.put_into_slot(holding_item)
				holding_item = temp
		else:
			slot.put_into_slot(holding_item)
			holding_item = null
	elif slot.item:
		holding_item = slot.item
		slot.pick_from_slot()
		holding_item.global_position = get_global_mouse_position()

func get_empty_slot(inv_name):
	var data = get_data(inv_name, slot_container)
	var index = 0
	for d in data:
		if d == null:
			return index
		index = index + 1
	return null

