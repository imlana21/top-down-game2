extends TileMap

var grid_size: int = 119
var tile_dic: Dictionary = {}

func _ready():
	for x in grid_size:
		for y in grid_size:
			tile_dic[str(Vector2(x, y))] = {
				"type": "Grass",
				"position": str(Vector2(x, y))
			}

func _physics_process(delta):
	set_resetter_hover()
	
func get_clicked_tile():
	var clicked_cell = local_to_map(get_local_mouse_position())
			
	if tile_dic.has(str(clicked_cell)):
		return Vector2i(global_position) + (clicked_cell * Vector2i(16, 16) + Vector2i(8, 8))
	else:
		return Vector2i.ZERO

func set_resetter_hover():
	var clicked_cell = local_to_map(get_local_mouse_position())
	for x in grid_size:
		for y in grid_size:
			erase_cell(1, Vector2i(x, y))
	if tile_dic.has(str(clicked_cell)):
		set_cell(1, clicked_cell, 0, Vector2i(0, 5))
