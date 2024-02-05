extends Node2D

@export var MAX_ENEMY = 5

signal change_scene
signal start_combat
signal player_near_board
	
func _ready():
	Autoload.world = self
	call_normal_enemy()
	call_boss_enemy()
	call_red_enemy()
	call_tree()

func _process(_delta):
	pause_config()

# if touch door, change scee
func _on_door_area_body_entered(_body):
	var next_path = 'res://scene/world/home/living_room/living_room.tscn'
	var current_scene = self
	change_scene.emit(next_path, current_scene, "WorldToLivingRoom")
	Autoload.world = null

func _on_cave_enter_area_body_entered(_body):
	var next_path = 'res://scene/world/cave/floor1/cave_floor1.tscn'
	var current_scene = self
	change_scene.emit(next_path, current_scene, "WorldToCave")
	Autoload.world = null

func _on_player_start_combat(enemy):
	match enemy.type:
		"normal":
			var enemy_index = Autoload.enemy_list.find(enemy.name)
			CombatDetail.coin_position.append(Autoload.enemy_position[enemy_index])
			if CombatDetail.spawn_chance(0.5):
				CombatDetail.tomato_position.append(Autoload.enemy_position[enemy_index] - Vector2(11, 0))
			Autoload.enemy_position.remove_at(enemy_index)
		"red":
			var enemy_index = Autoload.red_enemy_list.find(enemy.name)
			Autoload.red_coin_position.append(Autoload.red_enemy_position[enemy_index])
			if CombatDetail.spawn_chance(0.5):
				CombatDetail.wheat_position.append(Autoload.red_enemy_position[enemy_index] - Vector2(11, 0))
			if CombatDetail.spawn_chance(0.3):
				CombatDetail.silver_key_position.append(Autoload.red_enemy_position[enemy_index] - Vector2(0, 10))
			Autoload.red_enemy_position.remove_at(enemy_index)
	# Emit Combat
	CombatDetail.enemy_detail = enemy.CHAR_DETAIL
	CombatDetail.enemy_type = enemy.type
	start_combat.emit(self)

func pause_config():
	Autoload.pause_scale = Vector2(0.5, 0.5)
	Autoload.pause_position = Autoload.player.get_global_position()

func call_normal_enemy():
	Autoload.enemy_list = []
	# Call small enemy
	for pos in Autoload.enemy_position:
		Autoload.spawn_enemy(self, pos, "normal")	
		
	if Autoload.enemy_position.size() < MAX_ENEMY:
		var countdown_instance = load("res://scene/enemies/countdown_spawner.tscn").instantiate()
		countdown_instance.connect("spawn_enemy", Autoload.scene_manager._on_timeout_spawn_enemy)
		Autoload.scene_manager.add_child(countdown_instance)
	
	for pos in CombatDetail.coin_position:
		CombatDetail.spawn_coin(self, pos, "normal")

	for pos in CombatDetail.tomato_position:
		CombatDetail.spawn_tomato(self, pos, "normal")

func call_boss_enemy():
	var bos_position = Vector2(768, -64)
	if CombatDetail.status_boss == "alive":
		Autoload.spawn_enemy(self, bos_position, "bos")
	elif CombatDetail.status_boss == "killed":
		CombatDetail.spawn_coin(self, bos_position, "bos")
		#CombatDetail.spawn_tomato(self, bos_position, "bos")
		#CombatDetail.spawn_wheat(self, bos_position, "bos")

func call_red_enemy():
	Autoload.red_enemy_list = []
	for pos in Autoload.red_enemy_position:
		Autoload.spawn_enemy(self, pos, "red")
	
	for pos in Autoload.red_coin_position:
		CombatDetail.spawn_coin(self, pos, "red")
	for pos in CombatDetail.wheat_position:
		CombatDetail.spawn_wheat(self, pos, "red")
	for pos in CombatDetail.silver_key_position:
		CombatDetail.spawn_silver_key(self, pos, "red")
		
func call_tree():
	for pos in Autoload.tree_position:
		var index = Autoload.tree_position.find(pos)
		Autoload.tree_position.remove_at(index)
		Autoload.spawn_tree(self, pos)
	
func _on_board_is_near_player(val):
	player_near_board.emit(val)
