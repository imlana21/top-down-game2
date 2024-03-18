class_name ItemsRareOre
extends Items

func _ready():
	set_item_detail("player", "rare_ore", 1, 12)
	set_kategory("ResourceItem")
	
func _on_ore_area_body_entered(body) -> void:
	pick_item(item_detail.inventory)
	queue_free()
