extends Panel

var is_mouse_hovered = false
var item: Dictionary
var is_in_craft: bool = false

signal inv_panel_hovered
signal inv_panel_unhovered
signal inv_panel_clicked
signal crafting_item_setted

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
		inv_panel_clicked.emit(self)

func reset_item():
	is_in_craft = false
	item = {}
	if get_child_count() > 0:
		for i in get_children():
			remove_child(i)

func set_item(val, is_result = false):
	reset_item()
	var crafting_item = load("res://scene/crafting_bench/item/crafting_item.tscn").instantiate()
	item = val
	crafting_item.set_item(item)
	crafting_item.scale = Vector2(0.8, 0.8)
	add_child(crafting_item)
	if !is_result:
		crafting_item_setted.emit(item)
