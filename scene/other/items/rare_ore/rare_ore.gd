class_name ItemsRareOre
extends CharacterBody2D

const kategory = "ResourceItem"
const item_detail: Dictionary = {
	"inventory":"player",
	"name":"rare_ore",
	"qty":1,
	"stack_size":12
}

func _on_ore_area_body_entered(body):
	queue_free()
	pick_ore()
	
func pick_ore():
	var empty_slot = Autoload.player_inventory.get_empty_slot("player")
	var item_class = InventoryItems.new()
	item_class.inc_qty(item_detail, empty_slot, kategory)
