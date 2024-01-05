extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	CombatDetail.level()
	$ProgressBar.min_value = 0
	$ProgressBar.max_value = CombatDetail.exp_max
	$ProgressNumber.text = progress_number()
	$ProgressLevel.text = str(CombatDetail.player_detail["level"])
	
func progress_number():
	return str(CombatDetail.player_detail["exp"]) + "/" + str(CombatDetail.exp_max)
