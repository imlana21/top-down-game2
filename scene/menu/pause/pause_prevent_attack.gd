extends Control

func _ready():
	$TogglePrevent.button_pressed = Autoload.prevent_attack

func _on_toggle_prevent_toggled(toggled_on):
	Autoload.prevent_attack = toggled_on
