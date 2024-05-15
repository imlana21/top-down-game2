extends Control

var data = null

func set_item(d):
	if d == null:
		reset_item()
		return
	data = d
	$Texture.texture = load(d.icon)
	if !d.active:
		modulate = "4d4d4d"
	else:
		modulate = "fff"
	anchors_preset = Control.PRESET_CENTER
	
func reset_item():
	$Texture.texture = null
	data = null
	modulate = "fff"
