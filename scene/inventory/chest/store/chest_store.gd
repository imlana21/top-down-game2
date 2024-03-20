extends Inventory

const PANEL_SCRIPT: GDScript = preload("res://scene/inventory/chest/store/store_panel.gd")
@onready var player_container: GridContainer = $PlayerInventory/Container
@onready var chest_container: GridContainer = $ChestInventory/Container
var holding_item = null

signal inventory_updated

func _ready():
	for inv in player_container.get_children():
		inv.connect("inv_panel_clicked", _inv_panel_clicked)
		inv.connect("spread_item", _player_spread_item)
	for inv in chest_container.get_children():
		inv.connect("inv_panel_clicked", _inv_panel_clicked)
		inv.connect("spread_item", _chest_spread_item)

func _input(_event):
	if holding_item:
		holding_item.global_position = get_global_mouse_position()
	if Input.is_action_just_pressed("inventory"):
		set_inventory(player_container, "player")
		set_inventory(chest_container, "chest")
	
func _inv_panel_clicked(slot, input_state = "") -> void:
	if holding_item:
		if slot.item:
			if slot.item.data.name == holding_item.data.name:
				var temp = slot.item
				var new_qty = slot.item.data.qty + holding_item.data.qty
				if new_qty <= slot.item.data.stack_size:
					slot.remove_child(slot.item)
					slot.put_into_slot(holding_item, slot.item, new_qty)
					slot.update_inventory_type(holding_item, input_state)
					holding_item = null
					set_inventory(player_container, "player")
					set_inventory(chest_container, "chest")
				else:
					slot.pick_from_slot()
					temp.global_position = get_global_mouse_position()
					slot.put_into_slot(holding_item)
					slot.update_inventory_type(holding_item, input_state)
					holding_item = temp
			else: 
				var temp = slot.item
				slot.pick_from_slot()
				temp.global_position = get_global_mouse_position()
				slot.put_into_slot(holding_item)
				slot.update_inventory_type(holding_item, input_state)
				holding_item = temp
		else:
			slot.put_into_slot(holding_item)
			slot.update_inventory_type(holding_item, input_state)
			holding_item = null
	elif slot.item:
		holding_item = slot.item
		slot.pick_from_slot()
		holding_item.global_position = get_global_mouse_position()

## Spread item
func _player_spread_item(slot: PANEL_SCRIPT) -> void:
	var data = slot.item.data
	if data.qty > 1 and holding_item == null:
		var mean = floor(data.qty / 2)
		var qty1 = data.qty - mean
		var qty2 = data.qty - qty1
		var inv_manager = InventoryItems.new()
		inv_manager.remove_item(data)
		data.qty = qty1
		inv_manager.add_item(data)
		data.slot_id = get_empty_slot("player", player_container)
		data.qty = qty2
		inv_manager.add_item(data, true)
		_init_slot_id(player_container)
		set_inventory(player_container, "player")

## Spread item
func _chest_spread_item(slot: PANEL_SCRIPT) -> void:
	var data = slot.item.data
	if data.qty > 1 and holding_item == null:
		var mean = floor(data.qty / 2)
		var qty1 = data.qty - mean
		var qty2 = data.qty - qty1
		var inv_manager = InventoryItems.new()
		inv_manager.remove_item(data)
		data.qty = qty1
		inv_manager.add_item(data)
		data.slot_id = get_empty_slot("chest", player_container)
		data.qty = qty2
		inv_manager.add_item(data, true)
		_init_slot_id(player_container)
		set_inventory(player_container, "chest")