extends VBoxContainer

var min_room5_pos = Vector2( - 255, 1256)
var max_room5_pos = Vector2(355, 1750)

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

	if text_arr[0] == "/getitem" and Autoload.cheat_mode:
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
	
	if text_arr[0] == "/warp":
		if text_arr[1] == "testing":
			var next_path = "res://scene/world/warp/warp_world.tscn"
			Autoload.scene_manager._on_change_scene(next_path, Autoload.world)
			return "move to warp world"
		elif text_arr[1] == "spawn":
			var next_path = "res://scene/world/world.tscn"
			Autoload.scene_manager._on_change_scene(next_path, Autoload.world)
			return "move to warp world"
		elif text_arr[1] == "empty":
			var next_path = "res://scene/world/warp_empty/warp_empty.tscn"
			Autoload.scene_manager._on_change_scene(next_path, Autoload.world)
			return "move to emptywarp world"
		
	if text_arr[0] == "/spawn":
		if text_arr.size() < 3:
			return "unregistered Command"
		if text_arr[1] == "enemy":
			var enemy_path = ""
			var random_pos = random_position()
			match text_arr[2]:
				"slime":
					enemy_path = "res://scene/enemies/slime/slime.tscn"
				"rakun":
					enemy_path = "res://scene/enemies/rakun/rakun.tscn"
				"spirit":
					enemy_path = "res://scene/enemies/spirit/spirit.tscn"
				_:
					return "monster not listed"
			spawn_enemy(enemy_path, Autoload.world, random_position())
			return "enemy  spawn  on  " + str(random_pos)
		if text_arr[1] == "to":
			if text_arr[2] == "mouse":
				print(Autoload.world.scene_file_path)
				Autoload.scene_manager._on_change_scene(Autoload.world.scene_file_path, Autoload.world, null, Autoload.world.get_local_mouse_position())
				return "player move to " + str(Autoload.player.global_position)
		if text_arr[1] == "slime" or text_arr[1] == "rakun" or text_arr[1] == "spirit":
			if text_arr[2] == "mouse":
				var enemy_path = "res://scene/enemies/" + text_arr[1] + "/" + text_arr[1] + ".tscn"
				var mouse_pos = Autoload.world.get_global_mouse_position()
				spawn_enemy(enemy_path, Autoload.world, mouse_pos)
				return "spawn  " + text_arr[1] + "  to   " + str(mouse_pos)

	return "unregistered Command"

## update status player on message
func update_status_user():
	if Autoload.cheat_mode:
		$Username/Status.text = "#"
	else:
		$Username/Status.text = "$"

func spawn_enemy(enemy_path, rooms, pos):
	var enemy_instance = load(enemy_path).instantiate()
	enemy_instance.position = pos
	enemy_instance.name = enemy_instance.name + str(pos.x) + "_" + str(pos.y)
	rooms.add_child(enemy_instance)

func random_position():
	randomize()
	var spawn_x = randi_range(min_room5_pos.x, max_room5_pos.x)
	var spawn_y = randi_range(min_room5_pos.y, max_room5_pos.y)
	return Vector2(spawn_x, spawn_y)
