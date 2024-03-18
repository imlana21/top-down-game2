class_name ItemsLeather
extends Items

func _ready():
	set_item_detail("player", "leather", 1, 3)
	set_kategory("ResourceItem")

func _on_enemy_detector_body_entered(body) -> void:
	var index = Autoload.leather_position.find(position)
	pick_item(item_detail.inventory)
	if index >= 0:
		Autoload.leather_position.remove_at(index)
	queue_free()
