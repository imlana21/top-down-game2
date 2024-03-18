extends CanvasLayer

func _ready():
	$Popup.visible = false
	
func _input(event):
	if Input.is_action_just_pressed("chat_toggle"):
		if Autoload.paused_on == "":
			$Popup.visible = true
			$Popup.z_index = 10
			$Popup/MarginContainer/TextInput.text = ""
			await get_tree().create_timer(0.5).timeout
			$Popup/MarginContainer/TextInput.grab_focus()
			Autoload.paused_on = "chat_popup"
		elif Autoload.paused_on == "chat_popup":
			$Popup.visible = false
			$Popup/MarginContainer/TextInput.release_focus()
			Autoload.paused_on = ""
