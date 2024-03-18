class_name ItemsOre
extends Items

func _ready():
	set_item_detail("player", "ore", 1, 12)
	set_kategory("ResourceItem")	

func _on_ore_area_body_entered(body) -> void:
	pick_item(item_detail.inventory)
	queue_free()

func count_down_spawn():
	var countdown_instance = load("res://scene/enemies/countdown_spawner.tscn").instantiate()
	countdown_instance.connect("spawn_enemy", Autoload.scene_manager._on_timeout_spawn_ore)
	Autoload.scene_manager.add_child(countdown_instance)
