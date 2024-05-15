extends Panel

@onready var item_scene = preload("res://scene/menu/tab/skills_item/item.tscn").instantiate()
var data = null
var is_mouse_hovered = false

signal skills_hovered
signal skills_unhovered

func set_panel(skill_data):
	data = skill_data
	item_scene.scale = Vector2(1.3, 1.3)
	set_anchor_center(item_scene)	
	item_scene.set_item(skill_data)
	add_child(item_scene)

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
	for item in get_children():
		data = null
		item.reset_item()
		remove_child(item)