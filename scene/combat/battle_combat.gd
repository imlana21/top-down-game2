extends Node2D

@onready var player = preload("res://scene/player/player.tscn").instantiate()
@onready var enemy = preload("res://scene/enemies/slime/slime.tscn").instantiate()
@onready var player_node = $Character/PlayerMarker
@onready var enemy_node = $Character/EnemyMarker
@onready var player_bar = $HealthBar/Player/ProgressBar
@onready var enemy_bar = $HealthBar/Enemy/ProgressBar2

var characters: Array = []
var repeat_turn = true

signal change_scene
signal change_combat

func _ready():
	Autoload.pause_scale = Vector2(1, 1)
	Autoload.pause_position = get_viewport_rect(). size / 2
	# Setup Enemy is Boss
	if CombatDetail.is_enemy_boss:
		enemy.CHAR_DETAIL = CombatDetail.enemy_detail
	# SetUp Battle Combat
	characters.append(player)
	characters.append(enemy)
	call_character(player, player_node, player_bar)
	call_character(enemy, enemy_node, enemy_bar)
	await get_tree().create_timer(2).timeout
	# Start Battle
	generate_turn()

func _process(_delta):
	player_bar.value = player.CHAR_DETAIL["curr_hp"]
	enemy_bar.value = enemy.CHAR_DETAIL["curr_hp"]
	
func call_character(char_instance, node, bar):
	if "enemy_name" in char_instance.CHAR_DETAIL and CombatDetail.is_enemy_boss:
		char_instance.scale = Vector2(18.0, 18.0)
		$Character/EnemyMarker.position += Vector2(0, -80)
	else:
		char_instance.scale = Vector2(6.0, 6.0)
	node.add_child(char_instance)
	# Set Bar
	bar.max_value = char_instance.CHAR_DETAIL["max_hp"]
	bar.min_value = 0

func generate_turn():
	var character_list = characters
	characters.sort_custom(_compare_intiative_attack)
	while(repeat_turn):
		for character in character_list:
			if CombatDetail.is_attacking == false: return
			take_damage(character)
			await get_tree().create_timer(CombatDetail.get_battle_speed(2.0)).timeout
			if character.CHAR_DETAIL["atk_speed"] >= 2 * character_list[1 - character_list.find(character)].CHAR_DETAIL["atk_speed"] and CombatDetail.is_attacking:
				take_damage(character)
				await get_tree().create_timer(CombatDetail.get_battle_speed(2.0)).timeout
				
			if !CombatDetail.is_attacking:
				battle_finished()
			
				
func lose_action(marker, character, message):
	await get_tree().create_timer(2).timeout
	$Label.text = message
	repeat_turn = false
	CombatDetail.is_attacking = false
	marker.remove_child(character)

func battle_finished():
	#Move to world
	var next_path = 'res://scene/rooms/world.tscn'
	var current_scene = self
	change_combat.emit(next_path, current_scene)
	
	CombatDetail.player_energy -= 1
	if CombatDetail.is_enemy_boss:
		CombatDetail.player_energy += 3
		CombatDetail.enemy_detail = {}
		CombatDetail.is_enemy_boss = false
		CombatDetail.is_boss_killed = true
	
func take_damage(character):
	$Label.text = character.name + " Turn"
	if 'enemy_name' in character.CHAR_DETAIL:
		player.take_damage(character.CHAR_DETAIL["str"])
		enemy.attacking()
	else:
		player.attacking()
		enemy.take_damage(character.CHAR_DETAIL["str"])
	
	if player.CHAR_DETAIL["curr_hp"] < 1:
		lose_action($Character/PlayerMarker, player, "Player Kalah")
	elif enemy.CHAR_DETAIL["curr_hp"] < 1:
		lose_action($Character/EnemyMarker, enemy, "Enemy Kalah")

func _compare_intiative_attack(a, b):
	return b.CHAR_DETAIL["atk_speed"] < a.CHAR_DETAIL["atk_speed"]
	
