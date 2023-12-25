extends Timer

@export var max_time = 10

signal spawn_enemy

func _ready():
	wait_time = max_time
	
func _on_timeout():
	spawn_enemy.emit()
	queue_free()
