class_name ItemsRawMeet
extends CharacterBody2D

const kategory = "FoodItem"
const item_detail: Dictionary = {
	"inventory":"player",
	"name":"meat",
	"qty":1,
	"stack_size":10
}

func _on_enemy_detector_body_entered(body):
	var index = Autoload.meat_position.find(position)
	pick()
	queue_free()
	if index >= 0:
		Autoload.meat_position.remove_at(index)
	
func pick():
	var empty_slot = Autoload.player_inventory.get_empty_slot("player")
	var item_class = InventoryItems.new()
	
	item_class.inc_qty(item_detail, empty_slot, kategory)

