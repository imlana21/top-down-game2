extends CanvasLayer

var is_store_chest: bool = false
var init_connect: bool = false

func _ready():
	init_connect = false
	#
func _input(_event):
	if Input.is_action_just_pressed("pick_item") and Autoload.chest_store:
		if Autoload.paused_on == "" or Autoload.paused_on == "store":
			$ChestStore.visible = !$ChestStore.visible
			$ChestStore.z_index = 10
			$ChestStore.scale = Autoload.pause_scale
			$ChestStore.position = Autoload.pause_position
			Autoload.toggle_pause("store")
