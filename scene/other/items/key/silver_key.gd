class_name ItemsKey
extends CharacterBody2D

const kategory = "ResourceItem"
const item_detail: Dictionary = {
	"inventory":"player",
	"name":"silver_key",
	"qty":1,
	"stack_size":1
}

func _ready():
	$SilverKeySprite.play("idle")
	
func _on_silver_key_area_body_entered(body):
	var index = CombatDetail.silver_key_position.find(position)
	pick_key()
	queue_free()
	if index >= 0:
		CombatDetail.silver_key_position.remove_at(index)
	
func pick_key():
	var empty_slot = Autoload.player_inventory.get_empty_slot("player")
	var item_class = InventoryItems.new()
	item_class.inc_qty(item_detail, empty_slot, kategory)
	
