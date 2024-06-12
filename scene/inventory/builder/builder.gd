extends Inventory

const PANEL_BUILDER: GDScript = preload("res://scene/inventory/builder/builder_panel.gd")
const PANEL_TOOLS: GDScript = preload("res://scene/inventory/builder/tools_panel.gd")

var holding_item = null
var output_from_state = null
var is_pointer_on_world: bool = false
var rotate_state = 0

@onready var builder_container: GridContainer = $BuilderContainer
# @onready var tool_container: GridContainer = $ToolsContainer

func _ready():
	inventory_name = "builder"
	# Initialize Builder Panel
	_init_slot_id(builder_container)
	for inv in builder_container.get_children():
		inv.connect("inv_panel_clicked", _builder_panel_clicked)
		inv.connect("inv_panel_hovered", _inv_panel_hovered)
		inv.connect("inv_panel_unhovered", _inv_panel_unhovered)
	
func _input(event):
	# if button Z pressed
	if Input.is_action_just_pressed("camera_mode"):
		_reset_holding_item()
	# if pointer holding item
	if holding_item:
		# floating item follow mouse
		holding_item.global_position = get_global_mouse_position()
		if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed and is_pointer_on_world:
			put_item_to_world()
		elif Input.is_mouse_button_pressed(MOUSE_BUTTON_RIGHT):
			if rotate_state < 3:
				rotate_state += 1
			else:
				rotate_state = 0
			match rotate_state:
				0:
					holding_item.rotation_degrees = 0
				1:
					holding_item.rotation_degrees = 90
				2:
					holding_item.rotation_degrees = -180
				3:
					holding_item.rotation_degrees = -90
	
func _builder_panel_clicked(slot: PANEL_BUILDER, input_state = "") -> void:
	# if pointer hold item and output state different with input state, reset hodling item
	if output_from_state != input_state and output_from_state != null:
		_reset_holding_item()
	elif holding_item:
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

func _tools_panel_clicked(slot: PANEL_TOOLS, input_state = "") -> void:
	# if pointer holding item, reset pointer
	if holding_item:
		_reset_holding_item()
	# if pointer not holding item, pick item from panel
	elif slot.item:
		holding_item = slot.pick_from_slot(holding_item)
		holding_item.global_position = get_global_mouse_position()

## For check where last panel clicked after holding item from panel
func _inv_panel_unhovered(input_state) -> void:
	is_pointer_on_world = true
	if holding_item and output_from_state == null:
		output_from_state = input_state

func _inv_panel_hovered(panel) -> void:
	is_pointer_on_world = false

## reset holding item on pointer
func _reset_holding_item() -> void:
	if holding_item != null:
		remove_child(holding_item)
		output_from_state = null
		holding_item = null
	# Initialize panel
	set_builder_inventory()

func set_builder_inventory():
	const data = {"id":"ToolItem009","inventory":"builder","name":"flag","qty":1,"slot_id":9,"stack_size": 1}
	var index: int = 0
	set_inventory(builder_container)
	for slot in builder_container.get_children():
		if index == (builder_container.get_child_count() - 1):
			slot.init_item_into_slot(data)
		index += 1

## action to put item into world after holding item from clicked 
## tool or builder panel
func put_item_to_world() -> void:
	var item_name = holding_item.data.name
	var new_item = load("res://scene/other/items/" + item_name +"/" + item_name +".tscn").instantiate()
	var inv_manager = InventoryItems.new()
	new_item.position = Vector2.ZERO
	# new_item.global_position = get_global_mouse_position()
	new_item.global_position = Autoload.world.get_node('MeshTileMap').get_clicked_tile()
	new_item.scale = Vector2(1, 1)
	new_item.rotation_degrees = holding_item.rotation_degrees
	Autoload.world.add_child(new_item)
	if holding_item.data.qty > 1:
		inv_manager.remove_item(holding_item.data)
		holding_item.data.qty -= 1
		inv_manager.add_item(holding_item.data)
	else:
		inv_manager.remove_item(holding_item.data)
		remove_child(holding_item)
		holding_item = null
	set_inventory(builder_container)
