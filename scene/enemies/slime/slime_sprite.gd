extends AnimatedSprite2D

func _ready():
	play("idle")
	
func _on_slime_enemy_animation():
	play("idle")
