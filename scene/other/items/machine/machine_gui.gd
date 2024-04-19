extends Control

signal close_window

func _on_button_pressed():
	close_window.emit()
