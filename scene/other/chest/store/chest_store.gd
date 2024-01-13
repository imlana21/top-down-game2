extends Node2D

const PANEL_SCRIPT: GDScript = preload("res://scene/other/chest/store/store_slot.gd")
@onready var player_container: GridContainer = $PlayerInventory/Container
@onready var chest_container: GridContainer = $ChestInventory/Container
var holding_item = null

func _ready():
	for inv in player_container.get_children():
		inv.connect("slot_input_event", _slot_input_event)
	for inv in chest_container.get_children():
		inv.connect("slot_input_event", _slot_input_event)

func _slot_input_event(slot: PANEL_SCRIPT):
	if holding_item != null:
		 #if slot has another item, put item to slot and move another item to parent
		if slot.item:
			var temp = slot.item
			slot.pick_from_slot()
			temp.global_position = get_global_mouse_position()
			slot.put_into_slot(holding_item)
			holding_item = temp
		else:
		 #if slot empty, put item to slot
			slot.put_into_slot(holding_item)
			holding_item = null
	elif slot.item:
		holding_item = slot.item
		slot.pick_from_slot()
		holding_item.global_position = get_global_mouse_position()

func _input(_event):
	if holding_item:
		holding_item.global_position = get_global_mouse_position() - Vector2(1, 1)
