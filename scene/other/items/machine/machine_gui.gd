extends Control

signal close_window
signal craft_success

var result = null
var item = null
var waiting_minutes = 0
var waiting_seconds = 0
var waiting_time = 0
var in_craft = false
var is_claimed = false

func _on_btn_close_pressed():
	close_window.emit()

func _on_btn_craft_pressed():
	if !in_craft:
		set_timer(result.wait_time)
		in_craft = true
		$BtnCraft.hide()
		set_progressbar()
	else:
		var inv_items = InventoryItems.new()
		var empty_slot = Autoload.player_inventory.get_empty_slot(result.inventory, Autoload.player_inventory.slot_container)
		inv_items.inc_qty(result, empty_slot, "ResourceItem")
		$BtnCraft.hide()
		reset_gui()
		craft_success.emit()

func _on_crafting_timer_timeout():
	set_timer(waiting_time - 1)

func set_progressbar():
	$CraftingProcess/Arrow.hide()
	$CraftingProcess/Loading.show()
	$CraftingProcess/Loading.min_value = 0
	$CraftingProcess/Loading.max_value = result.wait_time + 1
	$CraftingProcess/Loading.step = 1

func set_timer(wait_time):
	if wait_time >= 0:
		waiting_time = wait_time
		waiting_seconds = wait_time % 60
		waiting_minutes = floor(wait_time / 60)
		$CraftingProcess/Loading.value += 1
		$LabelTimer.text = (str(waiting_minutes).pad_zeros(2) + ":" + str(waiting_seconds).pad_zeros(2))
		$CraftingTimer.start()
		$LabelTimer.show()
	if wait_time == 0:
		$LabelTimer.text = "00:00"
		$BtnCraft.text = "Claim"
		$BtnCraft.show()

func set_gui():
	$CraftingProcess.show()
	$ProductName.show()
	
func reset_gui():
	in_craft = false
	is_claimed = false
	waiting_minutes = 0
	waiting_seconds = 0
	waiting_time = 0
	result = null
	item = null
	$BtnCraft.hide()
	$LabelTimer.hide()
	$ProductName.hide()
	$CraftingProcess/Arrow.show()
	$CraftingProcess/Loading.hide()
	$CraftingProcess/Materials.reset_item()
	$CraftingProcess/Results.reset_item()
	$Inventory.hide()

func _on_materials_inv_panel_clicked():
	$Inventory.show()

func _on_inventory_send_item_to_crafting(item_data):
	var inv_manager = InventoryItems.new()
	var qty_material = inv_manager.get_total_qty_by_name(item_data.name)
	$LabelTimer.hide()
	$ProductName.hide()
	$CraftingProcess/Materials.reset_item()
	$CraftingProcess/Materials.set_item(item_data)
	if item_data.name == "wood":
		result = {
			"name": "charcoal",
			"inventory": "player",
			"qty": 1,
			"stack_size": 12,
			"wait_time": 5
		}
		if qty_material > 0:
			set_gui()
			if !in_craft:
				$BtnCraft.text = "Craft"
				$BtnCraft.show()
		else:
			reset_gui()
		$CraftingProcess/Results.set_item(result)
	else:
		result = {}
		$CraftingProcess/Results.reset_item()
