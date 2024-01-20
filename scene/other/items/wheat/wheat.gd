extends CharacterBody2D

var value: int = 0
var enemy_status: String = ""
const item_detail: Dictionary = {
	"inventory":"player",
	"name":"wheat",
	"qty":1,
	"stack_size":12
}

func _on_wheat_area_detector_player_entered(_body) -> void:
	var wheat_index = CombatDetail.wheat_position.find(position)
	pick_wheat()
	queue_free()
	if wheat_index >= 0:
		CombatDetail.wheat_position.remove_at(wheat_index)

func pick_wheat() -> void:
	#var inventory_container = Autoload.player_inventory.slot_container
	var empty_slot = Autoload.player_inventory.get_empty_slot("player")
	var item_class = InventoryItems.new()
	
	item_class.inc_qty(item_detail, empty_slot)
