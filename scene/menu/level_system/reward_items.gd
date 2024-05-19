extends Control

func set_reward(keys, values):
	$TextureRect.texture = load("res://assets/Objects/" + keys +".png")
	$Label.text = str(values)
	custom_minimum_size = Vector2(70, 70)

func reset_reward():
	$TextureRect.texture = null
	$Label.text = ""