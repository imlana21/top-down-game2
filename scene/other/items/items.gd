class_name Items
extends CharacterBody2D

var value: int = 0
var enemy_status: String = ""
var kategory: String
var item_detail: Dictionary = {
	"inventory": "",
	"name":"",
	"qty":0,
	"stack_size":0
}

func set_kategory(val):
	kategory = val
	
func set_item_detail(
	inventory: String, 
	iname: String, 
	iqty: int, 
	stack_size: int 
):
	item_detail = {
		"inventory": inventory,
		"name": iname,
		"qty": iqty,
		"stack_size": stack_size
	}

func get_item_detail():
	return item_detail
	
func set_item_qty(qty: int):
	item_detail.qty = qty
	
func pick_item(inventory_name: String):
	var empty_slot = Autoload.player_inventory.get_empty_slot(inventory_name, Autoload.player_inventory.slot_container)
	var item_class = InventoryItems.new()
	item_class.inc_qty(item_detail, empty_slot, kategory)
