extends Control

@onready var HPLabel = $PlayerDetail/MarginContainer/VBoxContainer/MaxHP/MaxHPValue
@onready var DefLabel = $PlayerDetail/MarginContainer/VBoxContainer/Def/DefValue
@onready var AtkSpeedLabel = $PlayerDetail/MarginContainer/VBoxContainer/AtkSpeed/AtkSpeedValue
@onready var StrengthLabel = $PlayerDetail/MarginContainer/VBoxContainer/Strength/StrengthValue
@onready var LuckLabel = $PlayerDetail/MarginContainer/VBoxContainer/Luck/LuckValue
	
func _process(_delta):
	HPLabel.text = str(Autoload.player.CHAR_DETAIL["curr_hp"]) + "/" + str(Autoload.player.CHAR_DETAIL["max_hp"])
	DefLabel.text = str(Autoload.player.CHAR_DETAIL["def"])
	AtkSpeedLabel.text = str(Autoload.player.CHAR_DETAIL["atk_speed"])
	StrengthLabel.text = str(Autoload.player.CHAR_DETAIL["str"])
	LuckLabel.text = str(Autoload.player.CHAR_DETAIL["luk"])

func _input(_event):
	if Input.is_action_just_released("pause"):
		$BattleSpeedBtn.set_pressed_btn()

func _on_exit_btn_pressed():
	get_tree().quit()

func _on_start_btn_pressed():
	if Autoload.paused_on == "pause":
		Autoload.toggle_pause("pause")
		$".".hide()
