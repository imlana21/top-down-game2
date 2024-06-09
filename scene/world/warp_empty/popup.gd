extends Control

var pockets_showed: bool = false
var holding_item = null

func _ready():
	reset_popup()

func _physics_process(delta):
	if holding_item:
		holding_item.global_position = get_global_mouse_position() - Vector2(1, 1)

func init_popup():
	scale = Autoload.pause_scale
	global_position = Autoload.player.get_global_position()
	visible = true
	z_index = 10	
	anchors_preset = Control.PRESET_FULL_RECT
	Autoload.paused_on = "popup_warp_chest"
	$ChestInventory.init_inventory()
	$Pockets.init_inventory()

func reset_popup():
	scale = Vector2.ZERO
	position = Autoload.player.get_global_position()
	visible = false
	z_index = 0 
	Autoload.paused_on = ""

func _on_chest_panel_clicked(panel, inv_name):
	if holding_item:
		if panel.item:
			pass
		else:
			panel.put_into_slot("ChestPopup", holding_item)
			panel.update_inventory_name(holding_item, inv_name)
			holding_item = null
	else:
		holding_item = panel.pick_from_slot("ChestPopup")
		holding_item.global_position = get_global_mouse_position()