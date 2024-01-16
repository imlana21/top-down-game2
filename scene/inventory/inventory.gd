extends Node2D

const PANEL_SCRIPT: GDScript = preload("res://scene/inventory/slot.gd")
@onready var slot_container: GridContainer = $InventoryContainer
var holding_item = null

func _ready():
	_init_slot_id()
	Autoload.player_inventory = self
	
func _input(_event):
	if Input.is_action_just_released("inventory"):
		set_inventory()
	if holding_item:
		holding_item.global_position = get_global_mouse_position() - Vector2(1, 1)

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
	
func set_inventory():
	var data = get_data('player')
	var index = 0
	
	for slot in slot_container.get_children():
		slot.init_item_into_slot(data[index])
		index += 1

func get_data(inv_name):
	var inv_class = InventoryItems.new()
	var data = inv_class.load_data("player") 
	var index = 0
	var temp_data = []
	
	for i in range(slot_container.get_children().size()):
		temp_data.append(null)
		
	for arr in data:
		for slot in slot_container.get_children():
			if arr.slot_id == slot.slot_id and arr.inventory == inv_name and temp_data[index] == null:
				temp_data[index] = arr
			index += 1
		index = 0
	return temp_data
	
func _init_slot_id():
	var inventory = slot_container.get_children()
	for index in inventory.size():
		inventory[index].slot_id = index

func get_empty_slot(inv_name):
	var data = get_data(inv_name)
	var index = 0
	for d in data:
		if d == null:
			return index
		index = index + 1
	return null
