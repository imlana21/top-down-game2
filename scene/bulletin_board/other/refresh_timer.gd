extends Timer

@export var MAX_TIME = 240 # 4 Minutes
var item_id: String

signal spawn

func _ready():
	wait_time = MAX_TIME
	
func _on_timeout():
	spawn.emit(item_id)
	queue_free()
