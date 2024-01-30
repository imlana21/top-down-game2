extends Control

func _on_exit_btn_pressed():
	get_tree().quit()

func _on_start_btn_pressed():
	Autoload.is_load_game = false
	get_tree().change_scene_to_file("res://scene/scene_manager.tscn")

func _on_continue_btn_pressed():
	await get_tree().create_timer(0.3).timeout
	$SaveLoadContainer.save_action = 'load'
	$SaveLoadContainer.is_from_main = true
	$SaveLoadContainer.visible = !$SaveLoadContainer.visible
	
