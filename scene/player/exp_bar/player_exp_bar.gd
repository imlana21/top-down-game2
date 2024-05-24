extends Control

# Called when the node enters the scene tree for the first time.
func _ready():
	if CombatDetail.first_init_level:
		CombatDetail.level_up()
	$ProgressBar.min_value = 0
	$ProgressBar.max_value = CombatDetail.exp_max
	$ProgressBar.value = CombatDetail.player_detail.exp
	$ProgressNumber.text =  str(CombatDetail.player_detail["exp"]) + "/" + str(CombatDetail.exp_max)
	$ProgressLevel.text = str(CombatDetail.player_detail["level"])

func _process(_delta):
	if Autoload.world and Autoload.player and !CombatDetail.first_init_level:
		CombatDetail.level_popup.init_level_popup(CombatDetail.player_detail.level)
		CombatDetail.first_init_level = true