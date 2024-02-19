extends Control

func _ready():
	var panel_list = $ProductContainer.get_children()
	for panel in panel_list:
		panel.connect("select_craft", _product_selected)
	_init_slot()
	$PopupCrafting.visible = false
	
func _init_slot():
	var panel_list = $ProductContainer.get_children()
	var index = 0
	var crafting_data = CraftingDataManager.new()
	crafting_data = crafting_data.get_all_data()
	for panel in panel_list:
		if index < crafting_data.size():
			set_panel(panel, crafting_data[index])
		else:
			reset_panel(panel)
		index += 1

func _product_selected(product):
	$PopupCrafting.pid = product.pid
	$PopupCrafting.pingredient = product.pingredient
	$PopupCrafting.pimg = product.pimg
	$PopupCrafting.pname = product.pname
	$PopupCrafting.ptype = product.ptype
	$PopupCrafting.ptime_cook = product.ptime_cook
	$PopupCrafting.show_crafting_popup()

func set_panel(panel, d):
	panel.set_product_id(d.id)
	panel.set_product_type(d.type)
	panel.set_time_cook(d.time)
	panel.set_product_name(d.name)
	panel.set_img_path(d.img)
	panel.set_ingredient(d.ingredient)
	panel.set_status(d.status)
	
func reset_panel(panel):
	panel.set_product_id(null)
	panel.set_product_type(null)
	panel.set_time_cook(null)
	panel.set_product_name(null)
	panel.set_img_path(null)
	panel.set_ingredient(null)
	panel.set_status(null)
	
