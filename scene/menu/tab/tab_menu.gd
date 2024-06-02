extends Control

var skills_hovered
var holding_item = null
var status_hold = 'idle'

@onready var panel_container: GridContainer = $ScrollContainer/GridContainer

func _ready():
	initialize_container()
	$SkillDetail/ColorRect.hide()
	$SkillDetail/Description.hide()

func _on_panel_skills_hovered(skill_data):
	$SkillDetail/ColorRect.show()
	$SkillDetail/Description.show()
	skills_hovered = skill_data
	$SkillDetail/Description.text = "Nama : " + skill_data.name + "\n" + "Description : " + skill_data.description

func _on_panel_skills_unhovered():
	$SkillDetail/Description.text = ""
	$SkillDetail/ColorRect.hide()
	$SkillDetail/Description.hide()
	skills_hovered = null

func _input(event):
	if holding_item:
		if status_hold == "hold":
			holding_item.global_position = get_global_mouse_position() + Vector2(50, 50)
		else:
			holding_item.global_position = get_global_mouse_position()
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT) and holding_item and Autoload.paused_on == "":
		put_to_world()
	control_zoom(event)
	control_buy(event)
	if Input.is_action_just_released('control'):
		$ScrollContainer.mouse_filter = MOUSE_FILTER_PASS
		reset_zoom()
		for i in get_children():
			if i == holding_item:
				remove_child(holding_item)
		holding_item = null
		status_hold = 'idle'
		initialize_container()

func control_zoom(event):
	if Input.is_action_pressed('control') and Autoload.paused_on == "tab_menu":
		$ScrollContainer.mouse_filter = MOUSE_FILTER_IGNORE
		if Input.is_mouse_button_pressed(MOUSE_BUTTON_WHEEL_UP):
			zoom_in()
		elif Input.is_mouse_button_pressed(MOUSE_BUTTON_WHEEL_DOWN):
			zoom_out()

func control_buy(event):
	if Input.is_action_just_pressed("buy") and skills_hovered != null:
		buy_skills()

func buy_skills():
	var skill_manager = SkillDataManager.new()
	skill_manager.update_status(skills_hovered, true)
	reset_containter()
	initialize_container()

func _on_panel_hold_skills_clicked(skill):
	if holding_item and status_hold == 'hold':
		if skill.item:
			var temp = skill.item
			skill.pick_from_slot()
			temp.global_position = get_global_mouse_position()
			skill.put_to_panel(holding_item)
			holding_item = temp
		else:
			skill.put_to_panel(holding_item)
			holding_item = null
	elif skill.item and status_hold == 'idle':
		holding_item = skill.pick_from_slot('hold')
		holding_item.global_position = get_global_mouse_position()
		status_hold = 'hold'

func _on_panel_just_skills_clicked(skill):
	if holding_item and status_hold == 'clicked':
		put_to_world()
	elif skill.item and status_hold == 'idle':
		holding_item = skill.pick_from_slot('clicked')
		holding_item.global_position = get_global_mouse_position()
		visible = false
		z_index = 0
		get_tree().paused = false
		Autoload.paused_on = ""
		status_hold = 'clicked'

func put_to_world():
	if holding_item and status_hold == 'clicked':
		holding_item.get_parent().remove_child(holding_item)
		holding_item = null
		initialize_container()
		await get_tree().create_timer(0.5).timeout
		visible = true
		Autoload.paused_on = "tab_menu"
		z_index = 10
		get_tree().paused = true
		status_hold = 'idle'

# Resetter and Initializer
func initialize_container():
	var index = 0
	var skill_manager = SkillDataManager.new()
	var skill_data = skill_manager.get_all_items()
	for panel in panel_container.get_children():
		panel.set_panel(skill_data[index])
		index += 1

func reset_containter():
	skills_hovered = null
	for panel in panel_container.get_children():
		panel.reset_panel()
		
# Zoom in and out
var scale_step: float = 0.1
var max_scale: Vector2 = Vector2(2, 2)
var min_scale: Vector2 = Vector2(1, 1)
@onready var viewport_scale: Vector2 = Vector2(get_viewport().size.x, get_viewport().size.y)
var anchor_factors: Vector2

func zoom_in():
	anchor_factors = get_global_mouse_position() - viewport_scale / 2
	if scale < max_scale:
		scale += Vector2(scale_step, scale_step)
		pivot_offset = anchor_factors

func zoom_out():
	anchor_factors = get_global_mouse_position() - viewport_scale / 2
	if scale > min_scale:
		scale -= Vector2(scale_step, scale_step)
		pivot_offset = anchor_factors

func reset_zoom():
	scale = min_scale
	pivot_offset = viewport_scale / 2
	anchors_preset = Control.PRESET_CENTER
