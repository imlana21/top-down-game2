class_name ItemsOre
extends CharacterBody2D

const kategory = "ResourceItem"
const item_detail: Dictionary = {
	"inventory":"player",
	"name":"ore",
	"qty":1,
	"stack_size":12
}

func _on_ore_area_body_entered(body):
	queue_free()
	pick_ore()
	
func pick_ore():
	var empty_slot = Autoload.player_inventory.get_empty_slot("player")
	var item_class = InventoryItems.new()
	item_class.inc_qty(item_detail, empty_slot, kategory)

func count_down_spawn():
	var countdown_instance = load("res://scene/enemies/countdown_spawner.tscn").instantiate()
	countdown_instance.connect("spawn_enemy", Autoload.scene_manager._on_timeout_spawn_ore)
	Autoload.scene_manager.add_child(countdown_instance)
