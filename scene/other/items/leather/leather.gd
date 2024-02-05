extends CharacterBody2D

const kategory = "ResourceItem"
const item_detail: Dictionary = {
	"inventory":"player",
	"name":"leather",
	"qty":1,
	"stack_size":3
}
	
func _on_enemy_detector_body_entered(body):
	var index = Autoload.leather_position.find(position)
	pick()
	queue_free()
	if index >= 0:
		Autoload.leather_position.remove_at(index)
	
func pick():
	var empty_slot = Autoload.player_inventory.get_empty_slot("player")
	var item_class = InventoryItems.new()
	
	item_class.inc_qty(item_detail, empty_slot, kategory)
