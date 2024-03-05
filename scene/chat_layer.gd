extends CanvasLayer

func _ready():
	$Popup.visible = false
	
func _input(event):
	if Input.is_action_just_pressed("chat_toggle"):
		if Autoload.paused_on == "" or Autoload.paused_on == "chat_popup":
			$Popup.visible = !$Popup.visible
			$Popup.z_index = 10
			Autoload.toggle_pause("chat_popup")
			
		if Autoload.paused_on == "chat_popup":
			$Popup/MarginContainer/TextInput.text = ""
			await get_tree().create_timer(0.5).timeout
			$Popup/MarginContainer/TextInput.grab_focus()
		else:
			$Popup/MarginContainer/TextInput.release_focus()
