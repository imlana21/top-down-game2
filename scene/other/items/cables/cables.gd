class_name ItemsCables
extends Items

func _ready():
	set_item_detail("player", "cable", 1, 15)
	set_kategory("MachineParts")

func _on_wood_area_body_entered(body) -> void:
	pick_item(item_detail.inventory)
	queue_free()
