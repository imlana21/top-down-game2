extends Control

func _on_exit_btn_pressed():
	get_tree().quit()

func _on_start_btn_pressed():
	Autoload.toggle_pause()
	if !Autoload.is_paused:
		$".".hide()
