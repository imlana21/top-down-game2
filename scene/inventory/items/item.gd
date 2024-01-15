extends Node2D

var item_name: String = ""
var item_qty: int = 0
var item_id: int = 0

func set_item(data):
	if int(data.qty) < 1 or data.name == "":
		reset_item()
		return
		
	item_name = data.name
	item_qty = int(data.qty)
	item_id = data.id
	$TextureRect.texture = load("res://assets/Objects/" + item_name + ".png")
	$Label.text = str(item_qty)

func reset_item():
	item_name = ""
	item_qty = 0
	item_id = 0
	$TextureRect.texture = null
	$Label.text = ""
	
func dec_item_qty(val):
	item_qty -= val
	$Label.text = str(val)
