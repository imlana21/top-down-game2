extends Control

@onready var slot_container = $Container
const inventory_name = "chest"

func _ready():
	get_chest_data()

func _input(event):
	if Input.is_action_just_released("pick_item"):
		get_chest_data()
	
func get_chest_data():
	var inv_class = InventoryItems.new()
	var data = inv_class.load_data("chest") 
	var index = 0
	
	for slot in slot_container.get_children():
		var item = {
			"name": "",
			"qty": 0,
			"id": ""
		}
		if index < data.size():
			item = data[index]
		if int(item.qty) > 0:
			slot.init_item_into_slot(item)
			index += 1
