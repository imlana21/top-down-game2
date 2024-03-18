class_name ItemsRawMeet
extends Items

func _ready():
	set_item_detail("player", "meat", 1, 10)
	set_kategory("FoodItem")

func _on_enemy_detector_body_entered(body) -> void:
	var index = Autoload.meat_position.find(position)
	pick_item(item_detail.inventory)
	if index >= 0:
		Autoload.meat_position.remove_at(index)
	queue_free()
