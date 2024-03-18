extends Inventory

const PANEL_SCRIPT: GDScript = preload("res://scene/inventory/chest/store/store_slot.gd")
@onready var player_container: GridContainer = $PlayerInventory/Container
@onready var chest_container: GridContainer = $ChestInventory/Container
var holding_item = null

signal inventory_updated

func _ready():
	for inv in player_container.get_children():
		inv.connect("slot_input_event", _slot_input_event)
	for inv in chest_container.get_children():
		inv.connect("slot_input_event", _slot_input_event)

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
		inventory_updated.emit()
	elif slot.item:
		holding_item = slot.item
		slot.pick_from_slot()
		holding_item.global_position = get_global_mouse_position()

func _input(_event):
	if holding_item:
		holding_item.global_position = get_global_mouse_position() - Vector2(1, 1)
