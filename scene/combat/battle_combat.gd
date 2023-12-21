extends Node2D

@onready var player = preload("res://scene/player/player.tscn").instantiate()
@onready var enemy = preload("res://scene/enemies/slime/slime.tscn").instantiate()
@onready var player_node = $Character/PlayerMarker
@onready var enemy_node = $Character/EnemyMarker
@onready var player_bar = $HealthBar/Player/ProgressBar
@onready var enemy_bar = $HealthBar/Enemy/ProgressBar2

var characters: Array = []
@export var turn_round = 10

func _ready():
	# Set attack to to prevent movement player
	CombatDetail.is_attacking = true
	
	# SetUp Battle Combat
	characters.append(player)
	characters.append(enemy)
	call_character(player, player_node, player_bar)
	call_character(enemy, enemy_node, enemy_bar)
	generate_turn()

func _process(delta):
	player_bar.value = player.CHAR_DETAIL["curr_hp"]
	enemy_bar.value = enemy.CHAR_DETAIL["curr_hp"]
	
func call_character(char_instance, node, bar):
	char_instance.scale = Vector2(7.0, 7.0)
	node.add_child(char_instance)
	# Set Bar
	bar.max_value = char_instance.CHAR_DETAIL["max_hp"]
	bar.min_value = 0

func generate_turn():
	# localization array
	var characters = characters
	characters.sort_custom(_compare_intiative_attack)
	
	for char in characters:
		take_damage(char)
		await get_tree().create_timer(2).timeout
		if char.CHAR_DETAIL["atk_speed"] >= 2 * characters[1 - characters.find(char)].CHAR_DETAIL["atk_speed"]:
			take_damage(char)
			await get_tree().create_timer(2).timeout

func take_damage(char):
	$Label.text = char.name + " Turn"
	if 'enemy_name' in char.CHAR_DETAIL:
		player.take_damage(char.CHAR_DETAIL["str"])
		enemy.attacking()
	else:
		player.attacking()
		enemy.take_damage(char.CHAR_DETAIL["str"])
			
func _compare_intiative_attack(a, b):
	return b.CHAR_DETAIL["atk_speed"] < a.CHAR_DETAIL["atk_speed"]
