extends Node2D

const PANEL_SCRIPT: GDScript = preload("res://scene/inventory/slot.gd")
@onready var slot_container: GridContainer = $InventoryContainer
var holding_item = null

func _ready():
	var index = 0
	for inv in slot_container.get_children():
		inv.connect("slot_input_event", _slot_input_event)
		inv.slot_index = index
		index += 1

func _slot_input_event(event: InputEvent, slot: PANEL_SCRIPT):
	if holding_item != null:
		# if slot has another item, put item to slot and move another item to parent
		if slot.item:
			
			var temp = slot.item
			slot.pick_from_slot()
			temp.global_position = event.global_position
			slot.put_into_slot(holding_item)
			holding_item = temp
		else:
		# if slot empty, put item to slot
			slot.put_into_slot(holding_item)
			holding_item = null
	else:
		holding_item = slot.item
		slot.pick_from_slot()
		holding_item.global_position = get_global_mouse_position()

func _input(event):
	if holding_item:
		holding_item.global_position = get_global_mouse_position() - Vector2(1, 1)
	

