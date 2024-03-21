class_name WarpWorld
extends Node2D

signal change_scene
signal start_combat
	
func _ready():
	Autoload.world = self

func _on_player_start_combat(enemy):
	CombatDetail.enemy_detail = enemy.CHAR_DETAIL
	CombatDetail.enemy_type = enemy.type
	start_combat.emit(self)


func _on_door_area_body_entered(body):
	pass # Replace with function body.
