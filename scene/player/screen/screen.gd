extends Node2D
var zoom_value: Vector2
var is_panel_viewed: bool = true

signal start_combat

func _ready():
	$Camera2D/BuilderInv.visible = false
	# $Camera2D.zoom = min_zoom

func _process(_delta):
	if !Autoload.is_spectator_mode:
		$Camera2D.position = $Player.position
		$Camera2D/BuilderInv.visible = false
	elif Autoload.paused_on == "" and Autoload.is_spectator_mode:
		$Camera2D.position += $Player.get_axis_input() * 5
		$Camera2D/BuilderInv.visible = is_panel_viewed
	$Camera2D/Curencies/EnergyBar/Energy.text = str(CombatDetail.player_energy)

func _input(event):
	if Input.is_action_just_pressed("camera_mode"):
		is_panel_viewed = true
		# zoom_reset()
		toggle_show_panel()
		Autoload.is_spectator_mode = !Autoload.is_spectator_mode
		
	if Input.is_action_just_pressed("view_panel"):
		is_panel_viewed = !is_panel_viewed
		toggle_show_panel()

	# if Input.is_action_pressed("zoom_in"):
	# 	zoom_in()
	# elif Input.is_action_pressed("zoom_out"):
	# 	zoom_out()
	
func _on_player_start_combat(enemy):
	start_combat.emit(enemy)

func toggle_show_panel():
	if Autoload.is_spectator_mode:
		$Camera2D/Curencies.visible = is_panel_viewed
		$Camera2D/BuilderInv.visible = is_panel_viewed

# func zoom_in():
# 	if zoom_value < max_zoom and Autoload.is_spectator_mode:
# 		for i in range(0, 10):
# 			zoom_value += Vector2((zoom_step/10), (zoom_step/10))
# 			$Camera2D.zoom = zoom_value
# 			$Camera2D/Curencies.scale -= Vector2(0.003, 0.003)
# 			$Camera2D/Curencies.position += Vector2(.001, 0)
# 			$Camera2D/BuilderInv.scale -= Vector2(0.0015, 0.0015)
# 			$Camera2D/BuilderInv.position.y -= 0.46
# 			await get_tree().create_timer(0.01).timeout

# func zoom_out():
# 	if zoom_value > min_zoom and Autoload.is_spectator_mode:
# 		for i in range(0, 10):
# 			zoom_value -= Vector2((zoom_step/10), (zoom_step/10))
# 			$Camera2D.zoom = zoom_value
# 			$Camera2D/Curencies.position -= Vector2(.001, 0)
# 			$Camera2D/Curencies.scale += Vector2(0.003, 0.003)
# 			$Camera2D/BuilderInv.scale += Vector2(0.0015, 0.0015)
# 			$Camera2D/BuilderInv.position.y += 0.46
# 			await get_tree().create_timer(0.01).timeout

# func zoom_reset():
# 	zoom_value = min_zoom
# 	$Camera2D.zoom = zoom_value
# 	$Camera2D/Curencies.scale = Vector2(1, 1)
# 	$Camera2D/Curencies.position = Vector2(0, 0)
# 	$Camera2D/BuilderInv.scale = Vector2(0.4, 0.4)
# 	$Camera2D/BuilderInv.position = Vector2(0, 136)
