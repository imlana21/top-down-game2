class_name ItemsWood
extends Items

func _ready():
	set_item_detail("player", "wood", 1, 20)
	set_kategory("ResourceItem")

func _on_wood_area_body_entered(body) -> void:
	pick_item(item_detail.inventory)
	queue_free()
