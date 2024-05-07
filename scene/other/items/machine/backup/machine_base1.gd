extends Control

var result = null
var item = null
var in_craft: bool = false
var waiting_minutes = 0
var waiting_seconds = 0
var waiting_time = 0

var crafting_result: Dictionary = {
	"wood": {
			"name": "charcoal",
			"inventory": "player",
			"qty": 1,
			"stack_size": 12,
			"wait_time": 5
		},
		"wheat": {
			"name": "bread",
			"inventory": "player",
			"qty": 1,
			"stack_size": 12,
			"wait_time": 5
		}
}

func _on_crafting_timer_timeout():
	set_timer(waiting_time - 1)

func set_progressbar(wait_time) -> void:
	$Arrow.hide()
	$Loading.show()
	$Loading.min_value = 0
	$Loading.max_value = wait_time + 1
	$Loading.step = 1

func _on_materials_crafting_item_setted(crafting_item):
	Autoload.machine_inventory.set_item_slot1(crafting_item)
	if crafting_result.has(crafting_item.name):
		Autoload.machine_inventory.set_result_slot1(crafting_result[crafting_item.name])
		$Results.set_item(crafting_result[crafting_item.name])
		$BtnCraft.show()

func _on_btn_craft_pressed():
	if !in_craft:
		set_timer(Autoload.machine_inventory.result_item.slot1.wait_time)
		in_craft = true
		$BtnCraft.hide()
		set_progressbar(Autoload.machine_inventory.result_item.slot1.wait_time)
	else:
		var inv_items = InventoryItems.new()
		var empty_slot = Autoload.player_inventory.get_empty_slot(result.inventory, Autoload.player_inventory.slot_container)
		inv_items.inc_qty(result, empty_slot, "ResourceItem")
		$BtnCraft.hide()
	print(Autoload.machine_inventory.queue_item)
	print(Autoload.machine_inventory.result_item)

func set_timer(wait_time):
	if wait_time >= 0:
		waiting_time = wait_time
		waiting_seconds = wait_time % 60
		waiting_minutes = floor(wait_time / 60)
		$Loading.value += 1
		$LabelTimer.text = (str(waiting_minutes).pad_zeros(2) + ":" + str(waiting_seconds).pad_zeros(2))
		$CraftingTimer.start()
		$LabelTimer.show()
	if wait_time == 0:
		$LabelTimer.text = "00:00"
		$BtnCraft.text = "Claim"
		$BtnCraft.show()