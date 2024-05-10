extends GridContainer

var panel_active = -1
var panel_list: Array
var panel_hovered: bool = false

func _ready():
	panel_list = []
	for panel in get_children():
		panel_list.append(panel)

func _on_panel_inv_panel_hovered(panel):
	panel_active = panel_list.find(panel)

func _input(event):
	# Activate status panel
	if Input.is_action_just_pressed("camera_mode"):
		panel_hovered = !panel_hovered

	# If inactive, nothing todo
	if !panel_hovered:
		return

	# If active can press number
	if Input.is_action_just_pressed("number_1"):
		restart_panel()	
		panel_list[0].mouse_hovered()
	elif Input.is_action_just_pressed("number_2"):
		restart_panel()	
		panel_list[1].mouse_hovered()
	elif Input.is_action_just_pressed("number_3"):
		restart_panel()	
		panel_list[2].mouse_hovered()
	elif Input.is_action_just_pressed("number_4"):
		restart_panel()	
		panel_list[3].mouse_hovered()
	elif Input.is_action_just_pressed("number_5"):
		restart_panel()		
		panel_list[4].mouse_hovered()
	elif Input.is_action_just_pressed("number_6"):
		restart_panel()		
		panel_list[5].mouse_hovered()
	elif Input.is_action_just_pressed("number_7"):
		restart_panel()		
		panel_list[6].mouse_hovered()
	elif Input.is_action_just_pressed("number_8"):
		restart_panel()		
		panel_list[7].mouse_hovered()
	elif Input.is_action_just_pressed("number_9"):
		restart_panel()		
		panel_list[8].mouse_hovered()

	if Input.is_mouse_button_pressed(MOUSE_BUTTON_WHEEL_UP):
			active_next_panel()
	elif Input.is_mouse_button_pressed(MOUSE_BUTTON_WHEEL_DOWN):
			active_previous_panel()

func active_next_panel():
	restart_panel()	
	if panel_active < panel_list.size() - 1:
		panel_active += 1
	else:
		panel_active = 0
	if panel_active >= 0:
		panel_list[panel_active].mouse_hovered()
	await get_tree().create_timer(0.5).timeout

func active_previous_panel():
	restart_panel()	
	if panel_active > 0:
		panel_active -= 1
	else:
		panel_active = panel_list.size() - 1
	if panel_active >= 0:
		panel_list[panel_active].mouse_hovered()
	await get_tree().create_timer(0.5).timeout

func restart_panel():
	for panel in get_children():
		panel.mouse_unhovered()