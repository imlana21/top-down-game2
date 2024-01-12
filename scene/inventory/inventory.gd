extends Node2D

const PANEL_SCRIPT: GDScript = preload("res://scene/inventory/slot.gd")
@onready var slot_container: GridContainer = $InventoryContainer
var holding_item = null

func _ready():
	for inv in slot_container.get_children():
		inv.connect("slot_input_event", _slot_input_event)
	get_inventoy_data()

func _slot_input_event(slot: PANEL_SCRIPT):
	if holding_item != null:
		# if slot has another item, put item to slot and move another item to parent
		if slot.item:
			var temp = slot.item
			slot.pick_from_slot()
			temp.global_position = get_global_mouse_position()
			slot.put_into_slot(holding_item)
			holding_item = temp
		else:
		# if slot empty, put item to slot
			slot.put_into_slot(holding_item)
			holding_item = null
	elif slot.item:
		holding_item = slot.item
		slot.pick_from_slot()
		holding_item.global_position = get_global_mouse_position()

func _input(_event):
	if holding_item:
		holding_item.global_position = get_global_mouse_position() - Vector2(1, 1)
	if Input.is_action_just_released("inventory"):
		get_inventoy_data()
	
func get_inventoy_data():
	var inv_class = InventoryItems.new()
	var data = inv_class.load_data() 
	var index = 0
	
	for item in data:
		var slot = slot_container.get_children()[index]
		if int(item.qty) > 0:
			slot.init_item_into_slot(item)
			index += 1
