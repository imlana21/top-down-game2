extends Control

# Called when the node enters the scene tree for the first time.
func _ready():
	if CombatDetail.first_init_level:
		CombatDetail.level_up()
	$ProgressBar.min_value = 0
	$ProgressBar.max_value = AutoloadPet.pet_exp_max
		

func _process(_delta):
	if Autoload.world and Autoload.player and !CombatDetail.first_init_level:
		CombatDetail.level_popup.init_level_popup(CombatDetail.player_detail.level)
		CombatDetail.first_init_level = true
	if AutoloadPet.pet_detail != null:
		$ProgressBar.value = AutoloadPet.pet_detail.exp
		$ProgressNumber.text =  str(AutoloadPet.pet_detail.exp) + "/" + str(AutoloadPet.pet_exp_max)
		$ProgressLevel.text = str(AutoloadPet.pet_detail.level)
