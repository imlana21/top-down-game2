extends CharacterBody2D

@export var SPEED = 700
@onready var nav_agent: NavigationAgent2D = $Node2D/SlimeNavigation

var player = null
var flee_distance = 50
var direction = 1

func _ready():
	nav_agent.path_desired_distance = 4
	nav_agent.target_desired_distance = 4
	$Node2D/ReCalcTimer.wait_time = 2
	#
func _physics_process(delta):
	if nav_agent.is_navigation_finished():
		return
		
	if player == null:
		position.x += direction * 0.5
	else:
		var axis = to_local(nav_agent.get_next_path_position()).normalized()
		velocity = axis * SPEED * delta
		move_and_slide()
#
func _on_re_calc_timer_timeout():
	if player == null:
		make_enemy_move_random()
	else:
		make_enemy_avoid_player()
		
func make_enemy_avoid_player():
	var direction_to_player = player.get_global_position() - get_global_position()
	var flee_position = get_global_position() - (direction_to_player.normalized() * flee_distance)
	
	nav_agent.target_position = flee_position

func make_enemy_move_random():
	direction = direction * -1

func _on_player_detector_body_entered(body):
	if body.is_in_group("player"):
		player = body
		$Node2D/ReCalcTimer.wait_time = 0.1
		
func _on_player_detector_body_exited(body):
	if body.is_in_group("player"):
		player = null
		$Node2D/ReCalcTimer.wait_time = 2
