extends CharacterBody2D

var value: int = 0
var enemy_status: String = ""
var item_detail: Dictionary = {
	"inventory":"player",
	"name":"tomato",
	"qty":1,
	"stack_size":12
}

func _on_tomato_area_detector_player_entered(_body):
	var tomato_index = CombatDetail.tomato_position.find(position)
	pick_apple()
	queue_free()
	if tomato_index >= 0:
		CombatDetail.tomato_position.remove_at(tomato_index)
	
func pick_apple():
	var empty_slot = Autoload.player_inventory.get_empty_slot('player')
	var item_class = InventoryItems.new()
	
	item_class.inc_qty(item_detail, empty_slot)
