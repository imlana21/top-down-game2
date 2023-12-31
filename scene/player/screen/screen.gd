extends Node2D

signal start_combat

func _process(_delta):
	# Move Camera position to follow user
	$Camera2D.position = $Player.position
	$Camera2D/Energy.text = str(CombatDetail.player_energy)
	
func _on_player_start_combat(enemy):
	start_combat.emit(enemy)
