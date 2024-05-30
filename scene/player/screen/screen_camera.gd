extends Camera2D

var zoom_step: float = 0.1
var max_zoom: Vector2 = Vector2(3, 3)
var min_zoom: Vector2 = Vector2(2, 2)

func _input(event):
	if event is InputEventMouseButton and Input.is_key_pressed(KEY_CTRL):
		if event is InputEventMouseButton:
			if event.button_index == MOUSE_BUTTON_WHEEL_UP:
				zoom_in(get_viewport().get_mouse_position())
			elif event.button_index == MOUSE_BUTTON_WHEEL_DOWN:
				zoom_out(get_viewport().get_mouse_position())

func zoom_in(pos):
	var new_zoom = zoom - Vector2(zoom_step, zoom_step)
	new_zoom = new_zoom.clamp(min_zoom, max_zoom)
	apply_zoom(new_zoom, pos)

func zoom_out(pos):
	var new_zoom = zoom + Vector2(zoom_step, zoom_step)
	new_zoom = new_zoom.clamp(min_zoom, max_zoom)
	apply_zoom(new_zoom, pos)

func apply_zoom(new_zoom, new_position):
	if new_zoom == zoom:
		return
	
  # Calculate the position of the mouse in world coordinates before the zoom
	var mouse_pos_world_before = get_global_mouse_position()

	# Apply the new zoom level
	zoom = new_zoom

	# Calculate the position of the mouse in world coordinates after the zoom
	var mouse_pos_world_after = get_global_mouse_position()

  # Adjust the camera position to keep the mouse position constant
	var adjustment = mouse_pos_world_before - mouse_pos_world_after
	global_position -= adjustment
