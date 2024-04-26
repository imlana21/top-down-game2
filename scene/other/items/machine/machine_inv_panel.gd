extends Panel

var slot_id: int
@onready var item_scene = preload("res://scene/inventory/_items/item.tscn")
var item = null
var inventory_name = null
var parent_name = null
var is_mouse_hovered = false

signal inv_panel_clicked

# Called when the node enters the scene tree for the first time.
func _ready():
	parent_name = "Pockets"
	refresh_style()

func _process(delta):
	if is_mouse_hovered and item and Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		inv_panel_clicked.emit(item)

func _on_mouse_entered():
	modulate = "eaeaea"
	is_mouse_hovered = true

func _on_mouse_exited():
	modulate = "fff"
	is_mouse_hovered = false

func refresh_style() -> void:
	self.modulate = "fff"

func init_item_into_slot(data, item_size = null) -> void:	
	if data != null:
		if item == null:
			item = item_scene.instantiate()
			item.scale = Vector2(0.7, 0.7)
			set_anchor_center(item)
			add_child(item)
			item.set_item(data)
		else:
			item.set_item(data)
	else:
		if item != null:
			remove_child(item)
		item = null
	refresh_style()

func set_anchor_center(i):
	i.anchors_preset = Control.PRESET_CENTER
