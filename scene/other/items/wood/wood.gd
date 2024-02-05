extends CharacterBody2D

const kategory = "ResourceItem"
const item_detail: Dictionary = {
	"inventory":"player",
	"name":"wood",
	"qty":1,
	"stack_size":20
}

func _on_wood_area_body_entered(body):
	queue_free()
	pick_wood()
	
func pick_wood():
	var empty_slot = Autoload.player_inventory.get_empty_slot("player")
	var item_class = InventoryItems.new()
	item_class.inc_qty(item_detail, empty_slot, kategory)
