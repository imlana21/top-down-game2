extends Node2D

var item_name: String = "tomato"
var item_qty: int = 0
var item_id: String

func set_item(data):
	item_name = data.name
	item_qty = int(data.qty)
	item_id = data.id
	$TextureRect.texture = load("res://assets/Objects/" + item_name + ".png")
	$Label.text = str(item_qty)
	
func dec_item_qty(val):
	item_qty -= val
	$Label.text = str(val)
