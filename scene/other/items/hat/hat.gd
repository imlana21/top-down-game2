extends CharacterBody2D

var item_object = null

func _ready():
	$Sprite.play('default')

func _on_farm_zone_body_entered(body):
	item_object = body
	item_object.is_dropped_item = false
	$FarmTimer.start()

func _on_farm_zone_body_exited(body):
	item_object = null

func _on_sprite_animation_finished():
	if item_object.hp < 1:
		queue_free()
	else:
		$Sprite.play('default')

func _on_farm_timer_timeout():
	if item_object:
		if item_object.farm_object():
			$FarmTimer.start()
			return
