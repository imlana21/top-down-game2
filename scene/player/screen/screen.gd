extends Node2D

signal start_combat

func _process(_delta):
	# Move Camera position to follow user
	if !Autoload.is_spectator_mode:
		$Camera2D.position = $Player.position
	else: 
		$Camera2D.position += $Player.get_axis_input()
	$Camera2D/Energy.text = str(CombatDetail.player_energy)
	
	
func _on_player_start_combat(enemy):
	start_combat.emit(enemy)

func _on_texture_button_pressed():
	Autoload.is_spectator_mode = !Autoload.is_spectator_mode
