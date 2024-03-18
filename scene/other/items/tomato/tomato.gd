class_name ItemsApple
extends Items

func _ready():
	set_item_detail("player", "apple", 1, 12)
	set_kategory("FoodItem")

func _on_tomato_area_detector_player_entered(body) -> void:
	var tomato_index = CombatDetail.tomato_position.find(position)
	pick_item(item_detail.inventory)
	if tomato_index >= 0:
		CombatDetail.tomato_position.remove_at(tomato_index)
	queue_free()
