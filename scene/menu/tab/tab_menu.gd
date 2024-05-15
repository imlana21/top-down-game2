extends Control

var skills_hovered

@onready var panel_container: GridContainer = $GridContainer

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