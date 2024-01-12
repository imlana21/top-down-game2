extends CharacterBody2D

func _ready():
	$GemSprite.play("idle")


func _on_gem_area_detector_player_entered(body):
	if body.is_in_group("player"):
		print("Player Entered")
		CombatDetail.gem += 1
		queue_free()
