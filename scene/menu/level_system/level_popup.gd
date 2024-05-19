extends Control

signal mouse_on_leftbar
signal mouse_out_leftbar
var mouse_leftbar:bool = false

func _ready():
	CombatDetail.level_popup = self
	visible = false

func _on_left_bar_mouse_entered():
	mouse_on_leftbar.emit()
	mouse_leftbar = true

func _on_left_bar_mouse_exited():
	mouse_out_leftbar.emit()
	mouse_leftbar = false

func _input(event):
	# $LevelPopup.global_position = Autoload.player.global_position
	# $LevelPopup.position = Autoload.pause_position
	if event is InputEventMouseButton and mouse_leftbar:
		visible = false
		z_index = 20
		get_tree().paused = false

func init_level_popup(level):
	var levelDataManager = LevelDataManager.new()
	var level_data = levelDataManager.laod_level(level)
	$RightBar/LevelArea/Level.text = str(level_data.level)
	set_skill_upgrade(level_data.skill_upgrades)
	set_reward(level_data.rewards)
	set_show()
	level_up_char(level_data.skill_upgrades)

func level_up_char(skill_up):
	CombatDetail.player_detail.atk_speed += skill_up.attack_speed
	CombatDetail.player_detail.max_hp += skill_up.hp
	CombatDetail.player_detail.curr_hp += skill_up.hp
	CombatDetail.player_detail.def += skill_up.defense
	CombatDetail.player_detail.str += skill_up.strength
	CombatDetail.player_detail.luk += skill_up.luck
	Autoload.player.CHAR_DETAIL = CombatDetail.player_detail

func set_show():
	if Autoload.world:
		visible = true
		z_index = 20
		get_tree().paused = true

func set_skill_upgrade(skill_list):
	$RightBar/SkillArea/SkillUp/HP.text = "HP +" + str(skill_list.hp)
	$RightBar/SkillArea/SkillUp/Def.text = "DEF +" + str(skill_list.defense)
	$RightBar/SkillArea/SkillUp/AtkSpd.text = "ATK SPD +" + str(skill_list.attack_speed)
	$RightBar/SkillArea/SkillUp/Str.text = "STR +" + str(skill_list.strength)
	$RightBar/SkillArea/SkillUp/Luck.text = "Luck +" + str(skill_list.luck)

func set_reward(reward_list):
	var keys = reward_list.keys()
	var values = reward_list.values()
	reset_reward()
	for i in len(reward_list):
		var reward_panel = load("res://scene/menu/level_system/reward_items.tscn").instantiate()
		reward_panel.set_reward(keys[i], values[i])
		$RightBar/RewardArea/RewardContainer/RewardsList.add_child(reward_panel)

func reset_reward():
	var children_list = $RightBar/RewardArea/RewardContainer/RewardsList.get_children()
	for child in children_list:
		remove_child(child)
