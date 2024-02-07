extends Node2D

var data = null

func set_item(d):
	if d == null:
		reset_item()
		return
	data = d
	data.qty = int(data.qty)
	$TextureRect.texture = load("res://assets/Objects/" + data.name + ".png")
	$Label.text = str(data.qty)

func reset_item():
	data = null
	print($TextureRect.texture)
	$TextureRect.texture = null
	$Label.text = ""
