extends CharacterBody2D

var CHAR_DETAIL = {
	"enemy_name": "slime",
	"atk_speed": 0.3,
	"max_hp": 30,
	"curr_hp": 30,
	"luk": 0.5,
	"def": 1,
	"str": 1
}

@export var SPEED = 700
@onready var nav_agent: NavigationAgent2D = $Node2D/SlimeNavigation

var target_node = null

signal change_attack

func _ready():
	nav_agent.path_desired_distance = 4
	nav_agent.target_desired_distance = 4
	
func _physics_process(delta):
	if nav_agent.is_navigation_finished() or CombatDetail.is_attacking:
		return
	
	var axis = to_local(nav_agent.get_next_path_position()).normalized()
	nav_agent.set_velocity(axis * SPEED * delta)
#
func _on_re_calc_timer_timeout():
	if target_node: 
		nav_agent.target_position = target_node.global_position

func _on_player_detector_body_entered(body):
	if body.is_in_group("player") and CombatDetail.is_attacking == false:
		target_node = body
	
func _on_slime_navigation_velocity_computed(safe_velocity):
	velocity = safe_velocity
	move_and_slide()

func take_damage(str):
	CHAR_DETAIL["curr_hp"] = CHAR_DETAIL["curr_hp"] - str
	
func attacking():
	change_attack.emit()
