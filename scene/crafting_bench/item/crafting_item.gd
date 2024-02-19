extends Control

var data = null

func set_item(d):
	if d == null:
		reset_item()
		return
	data = d
	$Texture.texture = load("res://assets/Objects/" + d.name + ".png")
	$Label.text = str(d.qty)
	_check_inv_qty()
	
func reset_item():
	$Texture.texture = null
	$Label.text = ""
	$Checklist.visible = false
	data = null

func _check_inv_qty():
	if data == null:
		return	
	var inv_manager = InventoryItems.new()
	if data.qty < inv_manager.get_total_qty_by_name(data.name):
		$Checklist.visible = true
	else:
		$Checklist.visible = false
