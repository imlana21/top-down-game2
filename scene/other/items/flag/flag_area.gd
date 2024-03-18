extends Area2D

var area_scale: Vector2 = Vector2(1, 1)
var area_count: int = 1
var scale_increment: Vector2 = Vector2(0.5, 0.5)

func _on_body_entered(body) -> void:
	if !body.is_in_group("flag") and !body.is_in_group("player"):
		body.queue_free()

func _on_area_entered(area: Area2D) -> void:
	var area_name: Array = area.name.split("_")
	if area_name[0] == "FlagArea":
		_update_area_size(area)
		
func _update_area_size(area: Area2D) -> void:
	self.area_count += 1
	if area.area_count < self.area_count:
		_update_area_position(area)
		area.queue_free()
	self.scale = self.area_scale + (self.scale_increment * self.area_count)
		
func _update_area_position(area: Area2D) -> void:
	var median: Vector2 = _get_area_median(area)
	# Geser x
	if area.global_position.x > self.global_position.x:
		self.position.x += median.x
	elif area.global_position.x < self.global_position.x:
		self.position.x -= median.x
	# Geser y
	if area.global_position.y > self.global_position.y:
		self.position.y += median.y
	elif area.global_position.y < self.global_position.y:
		self.position.y -= median.y
	
func _get_area_median(area: Area2D) -> Vector2:
	var median: Vector2 = (get_global_position() - area.get_global_position())/2
	median.x = abs(median.x)
	median.y = abs(median.y)
	return median

