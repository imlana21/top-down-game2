extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	for tree in get_children():
		tree.connect("drop_item", _drop_item_from_tree)

func _drop_item_from_tree(tree):
	var apple_scene = load("res://scene/other/items/tomato/tomato.tscn").instantiate()
	apple_scene.global_position = tree.current_position
	apple_scene.scale = Vector2(0.4, 0.4)
	add_child(apple_scene)
