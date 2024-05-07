extends Control

signal close_window
signal craft_success


func _on_btn_close_pressed():
	close_window.emit()

func _on_materials_inv_panel_clicked(craft_panel):
	$Inventory.inv_init(craft_panel)
	$Inventory.show()
