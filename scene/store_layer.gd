extends CanvasLayer

var is_store_chest: bool = false
var init_connect: bool = false

func _ready():
	init_connect = false

func _process(delta):
	if Autoload.chest_store != null and !init_connect:
		Autoload.chest_store.connect("player_near_chest", _on_player_near_store_chest)
		init_connect = true
	
func _input(_event):
	if Input.is_action_just_pressed("pick_item") and is_store_chest:
		if Autoload.paused_on == "" or Autoload.paused_on == "store":
			$ChestStore.visible = !$ChestStore.visible
			$ChestStore.z_index = 10
			$ChestStore.scale = Autoload.pause_scale
			$ChestStore.position = Autoload.pause_position
			Autoload.toggle_pause("store")
		
func _on_player_near_store_chest(val):
	print("DEkat chest")
	is_store_chest = val
