extends Node2D

@export var MAX_ENEMY = 5

@onready var countdown_spawn = preload("res://scene/enemies/countdown_spawner.tscn")

signal change_scene
signal start_combat

func _init():
	Autoload.world = self
	
func _ready():
	Autoload.enemy_list = []
	for pos in Autoload.enemy_position:
		Autoload.spawn_enemy(self, pos)
		
	if Autoload.enemy_position.size() < MAX_ENEMY:
		var countdown_instance = countdown_spawn.instantiate()
		countdown_instance.connect("spawn_enemy", Autoload.scene_manager._on_timeout_spawn_enemy)
		Autoload.scene_manager.add_child(countdown_instance)

func _process(delta):
	pause_config()

# if touch door, change scee
func _on_door_area_body_entered(body):
	var next_path = 'res://scene/rooms/home/living_room.tscn'
	var current_scene = self
	change_scene.emit(next_path, current_scene)

func _on_player_start_combat(enemy):
	# Remove enemy from array
	var enemy_index = Autoload.enemy_list.find(enemy.name)
	Autoload.enemy_position.remove_at(enemy_index)
	# Emit Combat
	start_combat.emit(self, enemy)
	
func _on_timeout_spawn_enemy():
	var random_pos = Autoload.random_position(self)
	print("Enemy muncul di ", random_pos)
	Autoload.spawn_enemy(self, random_pos)	

func pause_config():
	Autoload.pause_scale = Vector2(0.5, 0.5)
	Autoload.pause_position = Autoload.player.get_global_position()	
