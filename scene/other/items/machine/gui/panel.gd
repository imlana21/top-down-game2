extends Panel

var item: Dictionary
var is_mouse_hovered = false

signal inv_panel_hovered
signal inv_panel_unhovered
signal inv_panel_clicked

func set_item(val):
	var crafting_item = load("res://scene/crafting_bench/item/crafting_item.tscn").instantiate()
	item = val
	crafting_item.set_item(item)
	crafting_item.scale = Vector2(0.8, 0.8)
	add_child(crafting_item)

func reset_item():
	item = {}
	if get_child_count() > 0:
		for i in get_children():
			remove_child(i)

func _on_mouse_entered():
	modulate = "eaeaea"
	is_mouse_hovered = true
	inv_panel_hovered.emit()
	
func _on_mouse_exited():
	modulate = "fff"
	is_mouse_hovered = false
	inv_panel_unhovered.emit()

func _input(event):
	if is_mouse_hovered and Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		inv_panel_clicked.emit()

