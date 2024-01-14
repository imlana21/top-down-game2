extends Control

@onready var slot_container = $Container
const inventory_name = "player"

func _ready():
	get_player_data()

func _input(event):
	if Input.is_action_just_released("pick_item"):
		get_player_data()
	
func get_player_data():
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
		if int(item.qty) > 0:
			slot.init_item_into_slot(item)
			index += 1
