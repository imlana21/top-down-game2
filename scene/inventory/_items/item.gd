extends Control

var data = null

func set_item(d):
	if d == null:
		reset_item()
		return
	data = d.duplicate()
	data.qty = int(data.qty)
	$TextureRect.texture_normal = load("res://assets/Objects/" + data.name + ".png")
	$Label.text = str(data.qty)
	label_visibility()
func reset_item():
	data = null
	$TextureRect.texture_normal = null
	$Label.text = ""
	
func update_qty(qty):
	data.qty = qty
	$Label.text = str(data.qty)
	label_visibility()

func label_visibility():
	if data.qty < 2:
		$Label.visible = false
	else:
		$Label.visible = true
