extends Control
	
@onready var HPLabel = $PlayerDetail/MarginContainer/VBoxContainer/MaxHP/MaxHPValue
@onready var DefLabel = $PlayerDetail/MarginContainer/VBoxContainer/Def/DefValue
@onready var AtkSpeedLabel = $PlayerDetail/MarginContainer/VBoxContainer/AtkSpeed/AtkSpeedValue
@onready var StrengthLabel = $PlayerDetail/MarginContainer/VBoxContainer/Strength/StrengthValue
@onready var LuckLabel = $PlayerDetail/MarginContainer/VBoxContainer/Luck/LuckValue

var popup_state = ""

signal load_game
	
func _process(_delta):
	HPLabel.text = str(Autoload.player.CHAR_DETAIL["curr_hp"]) + "/" + str(Autoload.player.CHAR_DETAIL["max_hp"])
	DefLabel.text = str(Autoload.player.CHAR_DETAIL["def"])
	AtkSpeedLabel.text = str(Autoload.player.CHAR_DETAIL["atk_speed"])
	StrengthLabel.text = str(Autoload.player.CHAR_DETAIL["str"])
	LuckLabel.text = str(Autoload.player.CHAR_DETAIL["luk"])
		
func _input(_event):
	if Input.is_action_just_released("pause"):
		$BattleSpeedBtn.set_pressed_btn()
		
	if $PlayerDetail.visible:
		popup_state = ""

func _on_exit_btn_pressed():
	get_tree().quit()

func _on_continue_btn_pressed():
	if Autoload.paused_on == "pause":
		Autoload.toggle_pause("pause")
		$".".hide()

func _on_new_btn_pressed():
	Autoload.scene_manager.new_game()
	load_game.emit()
	
func _on_save_btn_pressed():
	if popup_state == "" or popup_state == "save":
		await get_tree().create_timer(0.3).timeout
		$PlayerDetail.visible = !$PlayerDetail.visible
		popup_state = "save"
		toggle_saveload(popup_state)

func _on_load_btn_pressed():
	if popup_state == "" or popup_state == "load":
		await get_tree().create_timer(0.3).timeout
		$PlayerDetail.visible = !$PlayerDetail.visible
		popup_state = "load"
		toggle_saveload(popup_state)
	
func _on_options_btn_pressed():
	pass # Replace with function body.
	
func toggle_saveload(action):
	$SaveLoadContainer.save_action = action
	$SaveLoadContainer.is_from_main = false
	$SaveLoadContainer.visible = !$SaveLoadContainer.visible

func _on_save_load_container_load_game_from_pause(data, action):
	if action == "load":
		Autoload.scene_manager.load_game()
	load_game.emit()
