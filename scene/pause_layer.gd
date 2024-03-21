extends CanvasLayer

func _ready():
	$Pause.connect('load_game', _on_load_close_pause)

func _input(_event):
	if Input.is_action_just_pressed("pause"):
		if Autoload.paused_on == "" or Autoload.paused_on == "pause":
			$Pause.visible = !$Pause.visible 
			$Pause.z_index = 10
			$Pause.scale = Autoload.pause_scale
			$Pause.position = Autoload.pause_position
			$Pause/SaveLoadContainer.visible = false
			$Pause/PlayerDetail.visible = true
			Autoload.toggle_pause("pause")

func _on_load_close_pause():
	$Pause.visible = !$Pause.visible 
	Autoload.toggle_pause("pause")

func _physics_process(delta):
	if Autoload.player != null and (Autoload.paused_on == "" or Autoload.paused_on == "pause"):
			$Pause.global_position = Autoload.player.global_position
