extends Inventory

const PANEL_SCRIPT: GDScript = preload("res://scene/inventory/pockets/pockets_slot.gd")

var holding_item = null
var hover_state = ""

@onready var slot_container = $InventoryContainer

func _ready():
	inventory_name = "player"
	_init_slot_id(slot_container)
	Autoload.player_inventory = self
	for inv in $InventoryContainer.get_children():
		inv.connect("spread_item", _spread_item)
		inv.connect("pick_one_item", _pick_one_item)
		inv.connect("inv_panel_clicked", _inv_panel_clicked)
		
func _input(_event):
	if Input.is_action_just_pressed("inventory") or Input.is_action_just_released("inventory"):
		set_inventory(slot_container)
	if holding_item:
		holding_item.global_position = get_global_mouse_position() - Vector2(1, 1)

func get_empty_slot(inv_name):
	var data = get_data(inv_name, slot_container)
	var index = 0
	for d in data:
		if d == null:
			return index
		index = index + 1
	return null
	
func _inv_panel_clicked(slot, inv_name):
	if holding_item:
		if slot.item:
			if slot.item.data.name == holding_item.data.name:
				var temp = slot.item
				var new_qty = slot.item.data.qty + holding_item.data.qty
				if new_qty <= slot.item.data.stack_size:
					slot.remove_child(slot.item)
					slot.put_into_slot(holding_item, slot.item, new_qty)
					set_inventory(slot_container)
					holding_item = null
				else:
					slot.pick_from_slot(holding_item)
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

## Spread item
func _spread_item(slot: PANEL_SCRIPT):
	var data = slot.item.data
	if data.qty > 1 and holding_item == null:
		var mean = floor(data.qty / 2)
		var qty1 = data.qty - mean
		var qty2 = data.qty - qty1
		var inv_manager = InventoryItems.new()
		inv_manager.remove_item(data)
		#data.qty = qty1
		#inv_manager.add_item(data)
		#data.slot_id = get_empty_slot("player")
		#data.qty = qty2
		#inv_manager.add_item(data, true)
		#_init_slot_id(slot_container)
		#set_inventory(slot_container)
##
func _pick_one_item(slot: PANEL_SCRIPT):
	var pick_one = slot.pick_one_from_slot(holding_item)
	if holding_item == null and pick_one != null:
		holding_item = pick_one
		add_child(holding_item)
	#
#func _set_holding_item(val):
	#if holding_item == null and val != null:
		#print("First Init")
		#holding_item = val
		#add_child(holding_item)
	#elif holding_item != null and val != null:
		#print("stack item or continue pick")
		#remove_child(holding_item)
		#holding_item = val
		#add_child(holding_item)
	#elif val == null and holding_item != null:
		#print("swap item")
		#remove_child(holding_item)
		#holding_item = val
	#elif val == null and holding_item == null:
		#print("nothing action")
		#holding_item = val
		
