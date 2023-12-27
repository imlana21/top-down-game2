extends Control

func _ready():
	$NormalSkin/Normal.play("default")
	$RedSkin/Red.play("default")


func _on_normal_skin_pressed():
	Autoload.player_skin = "normal"
	hide()
	continue_game()


func _on_red_skin_pressed():
	Autoload.player_skin = "red"
	hide()
	continue_game()
	
func continue_game():
	Autoload.toggle_pause()
	if !Autoload.is_paused:
		$".".hide()
