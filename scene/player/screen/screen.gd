extends Node2D

signal start_combat

func _process(_delta):
	# Move Camera position to follow user
	if !Autoload.is_spectator_mode:
		$Camera2D.position = $Player.position
		$Camera2D/ButtonGroup.visible = false
	else: 
		$Camera2D.position += $Player.get_axis_input() * 5
		$Camera2D/ButtonGroup.visible = true
	$Camera2D/Curencies/Energy.text = str(CombatDetail.player_energy)

func _input(event):
	if Input.is_action_just_pressed("camera_mode"):
		Autoload.is_spectator_mode = !Autoload.is_spectator_mode		
	
func _on_player_start_combat(enemy):
	start_combat.emit(enemy)

func _on_texture_button_pressed():
	Autoload.is_spectator_mode = !Autoload.is_spectator_mode
