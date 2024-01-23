extends Timer

@export var MAX_TIME = 10
var status_world = false
var spawn_position = Vector2.ZERO

signal spawn_enemy

func _ready():
	wait_time = MAX_TIME
	
func _process(_delta):
	if status_world and Autoload.world != null:
		clear_timer()
	
func _on_timeout():
	if Autoload.world != null:
		clear_timer()
	else:
		status_world = true

func clear_timer():
	spawn_enemy.emit(spawn_position)
	queue_free()
