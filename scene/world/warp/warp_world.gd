class_name WarpWorld
extends Node2D

var is_finish_reached: bool = false

signal change_scene
signal start_combat
	
func _ready():
	Autoload.world = self
	Autoload.pause_scale = Vector2(0.5, 0.5)
	Autoload.pause_position = Autoload.player.get_global_position()
	
func _on_player_start_combat(enemy):
	CombatDetail.enemy_detail = enemy.CHAR_DETAIL
	CombatDetail.enemy_type = enemy.type
	start_combat.emit(self)

func _on_finish_door_player_entered(body):
	if !is_finish_reached:
		$Room2.call_slimes()
		$SpawnerTimer.start()
	is_finish_reached = true
