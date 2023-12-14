extends Node2D

var next_scene = null
var current_scene = null

@onready var anim_trans = $ScreenTransition/AnimationTransition

func _on_change_scene(next_path, current):
	next_scene = load(next_path).instantiate()
	next_scene.connect("change_scene", _on_change_scene)
	current_scene = current
	anim_trans.play("fade_in")

func _on_animation_transition_finished(anim_name):
	match anim_name:
		"fade_in":
			add_child(next_scene)
			current_scene.queue_free()
			anim_trans.play("fade_out")
		"fade_out":
			current_scene = next_scene
			next_scene = null
