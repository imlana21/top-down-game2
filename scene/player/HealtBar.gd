extends ProgressBar

const MAX_VALUE = 100
const MIN_VALUE = 0

func _ready():
	max_value = MAX_VALUE
	min_value = MIN_VALUE
	hide()

func _on_player_sprite_player_idle():
	hide()

func _on_player_sprite_player_move():
	show()
