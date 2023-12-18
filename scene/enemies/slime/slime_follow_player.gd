extends CharacterBody2D

@export var SPEED = 700
@onready var nav_agent: NavigationAgent2D = $Node2D/SlimeNavigation

var target_node = null
#var home_node = null

func _ready():
	#home_node = get_global_position()
	#target_node = Autoload.player
	#
	nav_agent.path_desired_distance = 4
	nav_agent.target_desired_distance = 4
	#
func _physics_process(delta):
	if nav_agent.is_navigation_finished():
		return
	
	var axis = to_local(nav_agent.get_next_path_position()).normalized()
	#velocity = axis * SPEED * delta
	nav_agent.set_velocity(axis * SPEED * delta)
	#move_and_slide()
#
func _on_re_calc_timer_timeout():
	if target_node: 
		nav_agent.target_position = target_node.global_position
	#else:
		#nav_agent.target_position = home_node

func _on_player_detector_body_entered(body):
	if body.is_in_group("player"):
		target_node = body

func _on_slime_navigation_velocity_computed(safe_velocity):
	velocity = safe_velocity
	move_and_slide()
