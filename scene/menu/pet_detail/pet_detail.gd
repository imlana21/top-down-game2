extends Control

var mouse_on_leftbar: bool = false

func _ready():
	visible = false
	z_index = 0
	get_tree().paused = false

func _on_button_pressed():
	visible = false
	z_index = 0
	get_tree().paused = false
	Autoload.paused_on = ""

func init_pet_popup():
	if AutoloadPet.pet_node:
		$RightBar/NameArea/Name.text = AutoloadPet.pet_detail.pet_name.capitalize()
		$RightBar/NameArea/Level.text = "Level :  " + str(AutoloadPet.pet_detail.level)
		$RightBar/NameArea/ExpProgress.text = "Exp :  " + str(AutoloadPet.pet_detail.exp) + "/" + str(AutoloadPet.pet_exp_max)
		$RightBar/SkillArea/SkillUp/HP.text = "HP :  " + str(AutoloadPet.pet_detail.curr_hp) + "/" + str(AutoloadPet.pet_detail.max_hp)
		$RightBar/SkillArea/SkillUp/Def.text = "Defense :  " + str(AutoloadPet.pet_detail.def)
		$RightBar/SkillArea/SkillUp/Str.text = "Strength :  " + str(AutoloadPet.pet_detail.str)
		$RightBar/SkillArea/SkillUp/Luck.text = "Luck :  " + str(AutoloadPet.pet_detail.luk)
		$RightBar/SkillArea/SkillUp/AtkSpd.text = "Attack Speed :  " + str(AutoloadPet.pet_detail.atk_speed)

func _input(event):
	if Input.is_action_just_pressed("show_pet_detail") and AutoloadPet.pet_node:
		init_pet_popup()
		visible = true
		z_index = 20
		visible = true
		await get_tree().create_timer(0.5).timeout
		print("Muncul")
		Autoload.toggle_pause("pet_detail")
	if mouse_on_leftbar and Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		visible = false
		z_index = 0 
		get_tree().paused = false
		Autoload.paused_on = ""
		
func _on_left_bar_mouse_entered():
	mouse_on_leftbar = true
	print("Show")

func _on_left_bar_mouse_exited():
	mouse_on_leftbar = false
	print("Hide")
