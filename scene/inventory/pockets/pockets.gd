extends Inventory

const PANEL_SCRIPT: GDScript = preload ("res://scene/inventory/pockets/pockets_slot.gd")

var holding_item = null
var hold_state = "idle"

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
	if Input.is_action_just_released("control") and holding_item:
		reset_inv_guy()
	if Input.is_action_pressed("control") and hold_state == "hold":
		if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
			put_to_world()
	if holding_item:
		holding_item.global_position = get_global_mouse_position() - Vector2(1, 1)

func reset_inv_guy():
	find_parent("InventoryLayer").remove_child(holding_item)
	holding_item = null
	set_inventory(slot_container)
	await get_tree().create_timer(0.5).timeout
	visible = true
	Autoload.paused_on = "inventory"
	z_index = 10
	get_tree().paused = true
	hold_state = "idle"
	
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
func _spread_item(slot: PANEL_SCRIPT) -> void:
	if holding_item == null and slot.item:
		spread_item(slot.item.data, slot_container, "player")
		
func _pick_one_item(slot: PANEL_SCRIPT):
	var pick_one = slot.pick_one_from_slot(holding_item)
	if holding_item == null and pick_one != null:
		holding_item = pick_one
		add_child(holding_item)

func _on__inv_panel_hold_item(panel):
	if panel.item and hold_state == "idle":
		holding_item = panel.pick_machine_parts()
		holding_item.global_position = get_global_mouse_position()
		visible = false
		z_index = 0
		get_tree().paused = false
		Autoload.paused_on = ""
		await get_tree().create_timer(0.2).timeout
		hold_state = "hold"

func put_to_world():
	if holding_item:
		var new_item = load("res://scene/other/items/" + holding_item.data.name + "/" + holding_item.data.name + ".tscn").instantiate()
		var inv_manager = InventoryItems.new()
		new_item.global_position = get_global_mouse_position()
		Autoload.world.add_child(new_item)
		var new_qty = holding_item.data.qty - 1
		holding_item.update_qty(new_qty)
		inv_manager.update_qty(holding_item.data, new_qty)
		reset_inv_guy()