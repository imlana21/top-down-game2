extends Control

@onready var player_container = $Container
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
	
	for item in data:
		var slot = player_container.get_children()[index]
		if int(item.qty) > 0:
			slot.init_item_into_slot(item)
			index += 1
