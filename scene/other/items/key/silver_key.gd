class_name ItemsKey
extends Items

func _ready():
	$SilverKeySprite.play("idle")
	set_item_detail("player", "silver_key", 1, 1)
	set_kategory("ResourceItem")
	
func _on_silver_key_area_body_entered(body) -> void:
	var index = CombatDetail.silver_key_position.find(position)
	pick_item(item_detail.inventory)
	if index >= 0:
		CombatDetail.silver_key_position.remove_at(index)
	queue_free()
