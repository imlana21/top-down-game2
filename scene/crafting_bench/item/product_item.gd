extends Control

var data = null

func set_item(d):
	if d == null:
		reset_item()
		return
	data = d
	$Texture.texture = load("res://assets/Objects/food/" + d + ".png")
	
func reset_item():
	$Texture.texture = null
	data = null
