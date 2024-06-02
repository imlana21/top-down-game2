extends Panel

@onready var item_scene = preload("res://scene/menu/tab/skills_item/item.tscn")
var item = null
var data = null
var is_mouse_hovered = false
var slot_id: int = 0

signal skills_hovered
signal skills_unhovered
signal skills_just_clicked
signal skills_hold_clicked

func _on_gui_input(event) -> void:
	if Input.is_action_pressed("control"):
		if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
			skills_hold_clicked.emit(self)
	elif Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT) and data != null:
		if data.active:
			skills_just_clicked.emit(self)

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

func pick_from_slot(state):
	var new_item = item.duplicate()
	new_item.data = item.data
	if state == 'hold':
		find_parent("TabMenu").add_child(new_item)
	else:
		new_item.scale = Vector2(0.2, 0.2)
		find_parent('TabMenuLayer').add_child(new_item)
	# refresh inventory
	reset_panel()
	return new_item

func put_to_panel(new_item, old_item = null):
	var skills_manager = SkillDataManager.new()
	find_parent("TabMenu").remove_child(new_item)
	skills_manager.update_panel_position(data, slot_id)
	set_anchor_center(new_item)
	add_child(new_item)
	item = new_item
	self_modulate = "fff"
