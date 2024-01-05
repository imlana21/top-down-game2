extends Control

func _ready():
	set_pressed_btn()
	
func _on_speed_1_pressed():
	CombatDetail.battle_speed = 1.0

func _on_speed_1_5_pressed():
	CombatDetail.battle_speed = 2.0

func _on_speed_2_pressed():
	CombatDetail.battle_speed = 3.0

func set_pressed_btn():
	match CombatDetail.battle_speed:
		1.0:
			$ButtonSpeedContainer/Speed1.grab_focus()
		2.0:
			$ButtonSpeedContainer/Speed1_5.grab_focus()
		3.0:
			$ButtonSpeedContainer/Speed2.grab_focus()	
