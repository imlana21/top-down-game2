extends VBoxContainer

func _ready():
	toggle_status_label()

func _on_text_input_text_submitted(new_text):
	print_debug("New Chat bubble called")
	var bubble = load("res://scene/chat/bubble/chat_bubble.tscn").instantiate()
	bubble.set_message(new_text, "imlana21")
	$MarginContainer/TextInput.text = ""
	$ChatContainer/Chat.add_child(bubble)
	toggle_status_label()
	

func toggle_status_label():
	if Autoload.cheat_mode:
		$MarginContainer/Status.text = "#"
	else:
		$MarginContainer/Status.text = "$"
