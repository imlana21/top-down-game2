extends Control

signal close_window
signal craft_success

func _ready():
	remove_gui()

func show_gui():
	visible = true
	z_index = 10
	scale = Vector2(1, 1)
	position = Autoload.pause_position
	$CraftingProcess/Base1.init_crafting_base()
	$CraftingProcess/Base2.init_crafting_base()

func remove_gui():
	visible = false
	z_index = 0
	scale = Vector2(1, 1)
	position = Autoload.pause_position
	$CraftingProcess/Base1.reset_base()
	$CraftingProcess/Base2.reset_base()

func _on_btn_close_pressed():
	if Autoload.machine_inventory:
		Autoload.machine_inventory.start_machine_timer()
	close_window.emit()

func _on_materials_inv_panel_clicked(craft_panel):
	if !craft_panel.is_in_craft:
		$Inventory.hide()
		await get_tree().create_timer(0.5).timeout
		$Inventory.show()
		$Inventory.inv_init(craft_panel)
	else:
		$Inventory.hide()

func _on_base_1_crafting_started():
	$Inventory.hide()
	
func _on_base_2_crafting_started():
	$Inventory.hide()