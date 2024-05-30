extends Panel

@onready var item_scene = preload("res://scene/menu/tab/skills_item/item.tscn")
var item = null
var data = null
var is_mouse_hovered = false

signal skills_hovered
signal skills_unhovered
signal skills_clicked

func _on_gui_input(event) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed and data != null:
		if data.active:
			skills_clicked.emit(self)

func set_panel(skill_data):
	data = skill_data
	item = item_scene.instantiate()
	item.scale = Vector2(1.3, 1.3)
	set_anchor_center(item)	
	item.set_item(skill_data)
	add_child(item)

func _on_mouse_entered() -> void:
	mouse_hovered()
	if data != null:
		skills_hovered.emit(data)

func _on_mouse_exited() -> void:
	mouse_unhovered()
	skills_unhovered.emit()

func mouse_unhovered() -> void:
	self_modulate = "fff"
	is_mouse_hovered = false	

func mouse_hovered() -> void:
	self_modulate = "ff9900c9"
	is_mouse_hovered = true	

func set_anchor_center(i) -> void:
	i.anchors_preset = Control.PRESET_CENTER

func reset_panel() -> void:
	for i in get_children():
		data = null
		i.reset_item()
		if item:
			remove_child(item)
			item = null

func pick_from_slot():
	var new_item = item.duplicate()
	new_item.scale = Vector2(0.2, 0.2)
	new_item.data = item.data
	new_item.anchors_preset = Control.PRESET_TOP_LEFT
	new_item.position = Vector2(0, 0)
	find_parent('TabMenuLayer').add_child(new_item)
	# refresh inventory
	reset_panel()
	return new_item

