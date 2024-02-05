extends CharacterBody2D

var is_player_near: bool = false

func _ready():
	Autoload.billboard = self

func _on_enemy_detector_body_entered(body):
	is_player_near = true

func _on_enemy_detector_body_exited(body):
	is_player_near = false
