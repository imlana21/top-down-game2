extends CharacterBody2D

var value: int = 0
var enemy_status: String = ""

func _ready():
	$CoinSprites.play("idle")
	if enemy_status == "bos":
		value = randi_range(22, 38)
	elif enemy_status == "red" :
		value = randi_range(40, 70)
	else:
		value = randi_range(2, 8)
		
func _on_coin_area_detector_player_entered(_body):
	var coin_index = CombatDetail.coin_position.find(position)
	var red_index = Autoload.red_coin_position.find(position)
	
	if coin_index >= 0:
		CombatDetail.coin_position.remove_at(coin_index)
	elif red_index >= 0:
		Autoload.red_coin_position.remove_at(red_index)
	else:
		CombatDetail.status_boss = "taken"
		
	CombatDetail.coin += value
	queue_free()
