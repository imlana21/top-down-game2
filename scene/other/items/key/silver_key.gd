extends CharacterBody2D

var value: int = 0
var enemy_status: String = ""

func _ready():
	$SilverKeySprite.play("idle")

func _on_tomato_area_detector_player_entered(_body):
	var index = CombatDetail.silver_key_position.find(position)
	pick_key()
	queue_free()
	if index >= 0:
		CombatDetail.silver_key_position.remove_at(index)
	
func pick_key():
	var item_class = InventoryItems.new()
	item_class.inc_qty({
		"inventory":"player",
		"name":"silver_key",
		"qty":1,
		"stack_size":1
	})
