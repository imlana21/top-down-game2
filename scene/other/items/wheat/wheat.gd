extends CharacterBody2D

var value: int = 0
var enemy_status: String = ""

func _on_wheat_area_detector_player_entered(_body):
	var wheat_index = CombatDetail.wheat_position.find(position)
	pick_wheat()
	if wheat_index >= 0:
		CombatDetail.wheat_position.remove_at(wheat_index)
		queue_free()

func pick_wheat():
	var item_class = InventoryItems.new()
	item_class.inc_qty('wheat', 1)
