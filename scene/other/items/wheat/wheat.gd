class_name ItemsWheat
extends Items

func _ready():
	set_item_detail("player", "wheat", 1, 12)
	set_kategory("FoodItem")
	
func _on_wheat_area_detector_player_entered(body) -> void:
	var wheat_index = CombatDetail.wheat_position.find(position)
	pick_item(item_detail.inventory)
	if wheat_index >= 0:
		CombatDetail.wheat_position.remove_at(wheat_index)
	queue_free()
