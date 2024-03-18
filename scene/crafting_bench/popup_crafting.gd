extends Control

var pid = null
var pingredient = null
var pimg = null
var pname = null
var ptype = null
var ptime_cook = null
var pinv = null
	
func show_crafting_popup():
	if pid != null or pingredient != null or pname != null:
		_set_crafting()
		_set_btn()
		visible = true
	else:
		visible = false
		
func _set_crafting():
	var panel_list = $Container/Resources.get_children()
	for index in panel_list.size() - 1:
		#Resources
		if index < pingredient.size():
			panel_list[index].visible = true
			panel_list[index].set_pingredient(pingredient[index])
			panel_list[index].set_pid(pid)
			if index == pingredient.size() - 1:
				panel_list[index].set_operator("=")
			else:
				panel_list[index].set_operator("+")
		else:
			_reset_crafting_panel(panel_list[index])
		# Result Crafting
		panel_list[4].set_result(pname, pimg)
	$ProductName.text = pname

func _reset_crafting_panel(panel):
	panel.visible = false
	panel.set_pingredient(null)
	panel.set_pid(null)

func _check_status_btn():
	var qty_inv = InventoryItems.new()
	for ingredient in pingredient:
		if ingredient.qty > qty_inv.get_total_qty_by_name(ingredient.name):
			return false
	return true

func _set_btn():
	if _check_status_btn():
		$BtnCraft.disabled = false
		$BtnCraft.visible = true
	else:
		$BtnCraft.disabled = true
		$BtnCraft.visible = false
	
var waiting_minutes = 0
var waiting_seconds = 0

func _on_btn_craft_pressed():
	var data_manager = CraftingDataManager.new()
	##reduce qty
	for ing in pingredient:
		data_manager.reduce_inv_qty(ing)
	##update status recipe and add timer
	if data_manager.update_status(self, "cook") and ptime_cook != null:
		_generate_to_inventory()

func _generate_to_inventory():
	var empty_slot = Autoload.player_inventory.get_empty_slot(pinv)
	var inv_manager = InventoryItems.new()
	var data_manager = CraftingDataManager.new()
	var item_detail = {
		"inventory": pinv,
		"name": pimg,
		"qty": 1,
		"stack_size": 20,
	}
	inv_manager.inc_qty(item_detail, empty_slot, ptype + "Item")
	data_manager.update_status(self, "order")
