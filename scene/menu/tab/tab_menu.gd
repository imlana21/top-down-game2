extends Control

var skills_hovered
var holding_item = null

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
	if Input.is_action_just_pressed("buy") and skills_hovered != null:
		buy_skills()
	if holding_item:
		holding_item.global_position = get_global_mouse_position()
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT) and holding_item and Autoload.paused_on == "":
		put_to_world()

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

func buy_skills():
	var skill_manager = SkillDataManager.new()
	skill_manager.update_status(skills_hovered, true)
	reset_containter()
	initialize_container()

func _on_panel_skills_clicked(skill):
	if holding_item:
		put_to_world()
	elif skill.item:
		holding_item = skill.pick_from_slot()
		holding_item.global_position = get_global_mouse_position()
		visible = false
		z_index = 0
		get_tree().paused = false
		Autoload.paused_on = ""

func put_to_world():
	if holding_item:
		print("Putting")
		holding_item.get_parent().remove_child(holding_item)
		holding_item = null
		initialize_container()
		await get_tree().create_timer(0.5).timeout
		visible = true
		Autoload.paused_on = "tab_menu"
		z_index = 10
		get_tree().paused = true
		
