extends VBoxContainer

func set_message(text, account):
	if !check_is_command(text):
		$Chat/Text.text = str(text)
		$Username/Text.text = str(account)
		return
	var main_cmd = check_main_command(text)
	$Chat/Text.text = main_cmd
	$Username/Text.text = "System"
	update_status_user()
	
func _on_timer_timeout():
	print_debug("Message delete")
	$AnimationPlayer.play("disappear")
	
func _on_animation_player_animation_finished(anim_name):
	queue_free()

## Is message start with "/". If true the message is command.
func check_is_command(text):
	if text.substr(0, 1) == "/":
		return true
	return false

func check_main_command(text):
	var text_arr = text.split(" ")
	if text_arr.size() < 2:
		return "unregistered Command"
	if text_arr[0] == "/cheatmode":
		if text_arr[1] == "activated":
			Autoload.cheat_mode = true
			return "cheatmode actived"
		elif text_arr[1] == "unactivated":
			Autoload.cheat_mode = false
			return "cheatmode unactived"
	elif text_arr[0] == "/getitem" and Autoload.cheat_mode:
		var inv_manager = InventoryItems.new()
		var items = null
		match text_arr[1]:
			"wheat":
				items = ItemsWheat.new()
				items.pick_wheat()
				return "wheat in inventory +1"
			"apple":
				items = ItemsApple.new()
				items.pick_apple()
				return "apple in inventory +1"
			"leather":
				items = ItemsLeather.new()
				items.pick()
				
				return "leather in inventory +1"
			"meet":
				items = ItemsRawMeet.new()
				items.pick()
				return "meet in inventory +1"
			"key":
				items = ItemsKey.new()
				items.pick_key()
				return "key in inventory +1"
			"ore":
				items = ItemsOre.new()
				items.pick_ore()
				return "ore in inventory +1"
			"rare_ore":
				items = ItemsRareOre.new()
				items.pick_ore()
				return "Rare Ore in inventory +1"
			"wood":
				items = ItemsWood.new()
				items.pick_wood()
				return "wood in inventory +1"
			_:
				return "items not listed"
	return "unregistered Command"

## update status player on message
func update_status_user():
	if Autoload.cheat_mode:
		$Username/Status.text = "#"
	else: 
		$Username/Status.text = "$"
	
