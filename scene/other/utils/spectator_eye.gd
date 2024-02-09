extends Node2D

func _on_texture_button_pressed():
	Autoload.is_spectator_mode = !Autoload.is_spectator_mode
