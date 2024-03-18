extends Inventory

const PANEL_BUILDER: GDScript = preload("res://scene/inventory/builder/builder_panel.gd")
const PANEL_TOOLS: GDScript = preload("res://scene/inventory/builder/tools_panel.gd")

var holding_item = null
var hover_state = ""
var output_event_state = null

@onready var builder_container: GridContainer = $BuilderContainer
@onready var tool_container: GridContainer = $ToolsContainer

func _ready():
	inventory_name = "builder"
	_init_slot_id(builder_container)
	for inv in builder_container.get_children():
		inv.connect("slot_input_event", _slot_input_event)
		inv.connect("slot_output_event", _slot_output_event)
	_init_slot_id(tool_container)
	for inv in tool_container.get_children():
		inv.connect("slot_input_event", _slot_input_event)
		inv.connect("slot_output_event", _slot_output_event)
	
func _input(event):
	if Input.is_action_just_pressed("camera_mode"):
		set_inventory(builder_container)
		set_tools_inventory()
	if holding_item:
		holding_item.global_position = get_global_mouse_position()
		if output_event_state and event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			put_item_to_world()
	
func get_empty_slot(inv_name):
	var data = get_data(inv_name, builder_container)
	var index = 0
	for d in data:
		if d == null:
			return index
		index = index + 1
	return null
	
func put_item_to_world():
	var item_name = holding_item.data.name
	var new_item = load("res://scene/other/items/" + item_name +"/" + item_name +".tscn").instantiate()
	var inv_manager = InventoryItems.new()
	new_item.position = Vector2.ZERO
	new_item.global_position = get_global_mouse_position()
	new_item.scale = Vector2(0.8, 0.8)
	Autoload.world.add_child(new_item)
	if holding_item.data.qty > 1:
		inv_manager.remove_item2(holding_item.data)
		holding_item.data.qty -= 1
		inv_manager.add_item(holding_item.data)
	else:
		inv_manager.remove_item2(holding_item.data)
		remove_child(holding_item)
		holding_item = null
	set_inventory(builder_container)

func _slot_input_event(slot: PANEL_TOOLS, input_state = ""):
	if holding_item:
		remove_child(holding_item)
		holding_item = null
	elif slot.item:
		holding_item = slot.pick_from_slot2(holding_item)
		holding_item.global_position = get_global_mouse_position()
	
func _slot_input_builder(slot: PANEL_BUILDER, input_state = ""):		
	if holding_item:
		if slot.item:
			if slot.item.data.name == holding_item.data.name:
				var temp = slot.item
				var new_qty = slot.item.data.qty + holding_item.data.qty
				if new_qty <= slot.item.data.stack_size:
					slot.remove_child(slot.item)
					slot.put_into_slot(holding_item, slot.item, new_qty)
					holding_item = null
					set_inventory(builder_container)
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
	
func _slot_output_event(input_state):
	if Autoload.is_spectator_mode and holding_item and output_event_state == null:
		output_event_state = input_state

func set_tools_inventory():
	var data = [{"id":"ToolItem001","inventory":"builder","name":"flag","qty":1,"slot_id":0,"stack_size": 1}]
	var index = 0
	for slot in tool_container.get_children():
		slot.init_item_into_slot(data[index])
		index += 1
	
func set_inventory(slot_container: GridContainer, d = null):
	var data = get_data(inventory_name, slot_container)
	var index = 0
	for slot in slot_container.get_children():
		slot.init_item_into_slot(data[index])
		index += 1
