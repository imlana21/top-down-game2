extends Inventory

const PANEL_SCRIPT: GDScript = preload("res://scene/inventory/pockets/pockets_slot.gd")
var holding_item = null
@onready var slot_container = $InventoryContainer
var hover_data = null

func _ready():
	inventory_name = "player"
	_init_slot_id(slot_container)
	Autoload.player_inventory = self
	for inv in $InventoryContainer.get_children():
		inv.connect("slot_hovered", _slot_hovered)
		inv.connect("slot_unhovered", _slot_unhovered)
	
func _input(_event):
	if Input.is_action_just_pressed("inventory") or Input.is_action_just_released("inventory"):
		set_inventory(slot_container)
	if Input.is_action_just_pressed("camera_mode") and hover_data:
		_spread_item()

func get_empty_slot(inv_name):
	var data = get_data(inv_name, slot_container)
	var index = 0
	for d in data:
		if d == null:
			return index
		index = index + 1
	return null
	
func _slot_hovered(slot):
	if slot.item:
		hover_data = slot.item.data

func _slot_unhovered(slot):
	hover_data = null

func _spread_item():
	if hover_data.qty > 1:
		var mean = floor(hover_data.qty / 2)
		var qty1 = hover_data.qty - mean
		var qty2 =hover_data.qty - qty1
		var inv_manager = InventoryItems.new()
		inv_manager.remove_item2(hover_data)
		hover_data.qty = qty1
		inv_manager.add_item(hover_data)
		hover_data.slot_id = get_empty_slot("player")
		hover_data.qty = qty2
		inv_manager.add_item(hover_data, true)
		_init_slot_id(slot_container)
		set_inventory(slot_container)
		
	
#func _slot_input_event(slot: PANEL_SCRIPT):
	#if holding_item:
		#if slot.item:
			#if slot.item.data.name == holding_item.data.name:
				#var temp = slot.item
				#var new_qty = slot.item.data.qty + holding_item.data.qty
				#if new_qty <= slot.item.data.stack_size:
					#slot.remove_child(slot.item)
					#slot.put_into_slot(holding_item, slot.item, new_qty)
					#holding_item = null
					#set_inventory(slot_container)
				#else:
					#slot.pick_from_slot()
					#temp.global_position = get_global_mouse_position()
					#slot.put_into_slot(holding_item)
					#holding_item = temp
			#else: 
				#var temp = slot.item
				#slot.pick_from_slot()
				#temp.global_position = get_global_mouse_position()
				#slot.put_into_slot(holding_item)
				#holding_item = temp
		#else:
			#slot.put_into_slot(holding_item)
			#holding_item = null
	#elif slot.item:
		#holding_item = slot.item
		#slot.pick_from_slot()
		#holding_item.global_position = get_global_mouse_position()
