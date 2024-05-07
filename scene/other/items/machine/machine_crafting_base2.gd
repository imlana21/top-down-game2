extends Control

var result = null
var item = null
var is_panel_in_craft: bool = false
var waiting_minutes = 0
var waiting_seconds = 0
var waiting_time = 0

signal crafting_started

func _on_materials_crafting_item_setted(crafting_item: Dictionary):
	Autoload.machine_inventory.set_item_slot2(crafting_item)
	if Autoload.machine_inventory.result_item.slot2:
		result = Autoload.machine_inventory.result_item.slot2
		$Results.set_item(result)
		$BtnCraft.show()
	else:
		reset_base()

func _on_btn_craft_pressed():
	if !is_panel_in_craft:
		is_panel_in_craft = true
		Autoload.machine_inventory.set_waiting_time_slot2()
		set_timer(Autoload.machine_inventory.waiting_time.slot2)
		set_progressbar(Autoload.machine_inventory.waiting_time.slot2)
		$Materials.is_in_craft = true
		crafting_started.emit()
	else:
		var inv_items = InventoryItems.new()
		var empty_slot = Autoload.player_inventory.get_empty_slot(result.inventory, Autoload.player_inventory.slot_container)
		inv_items.inc_qty(result, empty_slot, "ResourceItem")
		$Materials.is_in_craft = false
		reset_base()
		Autoload.machine_inventory.reset_slot2()

func _on_crafting_timer_timeout():
	set_timer(waiting_time - 1)

func reset_base():
	$Materials.reset_item()
	$Results.reset_item()
	waiting_minutes = 0
	waiting_seconds = 0
	waiting_time = 0
	item = null
	result = null
	is_panel_in_craft = false
	$ProductName.text = "Product"
	$Loading.hide()
	$Arrow.show()
	$BtnCraft.hide()
	$BtnCraft.text = "Craft"

func set_progressbar(wait_time) -> void:
	$Arrow.hide()
	$Loading.show()
	$Loading.min_value = 0
	$Loading.max_value = wait_time + 1
	$Loading.step = 1

func set_timer(wait_time):
	if wait_time >= 0:
		waiting_time = wait_time
		waiting_seconds = wait_time % 60
		waiting_minutes = floor(wait_time / 60)
		$Loading.value += 1
		$BtnCraft.text = (str(waiting_minutes).pad_zeros(2) + ":" + str(waiting_seconds).pad_zeros(2))
		$BtnCraft.disabled = true
		$CraftingTimer.start()
		if Autoload.machine_inventory:
			Autoload.machine_inventory.set_waiting_time_slot2(wait_time)
	if wait_time == 0:
		$BtnCraft.disabled = false
		$BtnCraft.text = "Claim"
		$BtnCraft.show()

func init_crafting_base():
	print(Autoload.machine_inventory.queue_item.slot2)
	if Autoload.machine_inventory.queue_item.slot2:
		item = Autoload.machine_inventory.queue_item.slot2
		$Materials.set_item(item)
		result = Autoload.machine_inventory.result_item.slot2
		$Results.set_item(result)
		$BtnCraft.show()
		waiting_time = Autoload.machine_inventory.waiting_time.slot2
		set_timer(waiting_time)
		set_progressbar(waiting_time)
		$Materials.is_in_craft = true
		is_panel_in_craft = true
		crafting_started.emit()
		return
	reset_base()