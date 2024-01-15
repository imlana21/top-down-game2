extends Node2D

const PANEL_SCRIPT: GDScript = preload("res://scene/inventory/slot.gd")
@onready var slot_container: GridContainer = $InventoryContainer
var holding_item = null

func _ready():
	get_inventoy_data()

func _input(_event):
	if Input.is_action_just_released("inventory"):
		get_inventoy_data()
	
func get_inventoy_data():
	var inv_class = InventoryItems.new()
	var data = inv_class.load_data("player") 
	var index = 0

	for slot in slot_container.get_children():
		var item = {
			"name": "",
			"qty": 0,
			"id": ""
		}
		if index < data.size():
			item = data[index]
			
		slot.init_item_into_slot(item)
		index += 1
