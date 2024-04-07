extends CharacterBody2D

var CHAR_DETAIL = {
	"enemy_name": "rakun",
	"atk_speed": 0.3,
	"max_hp": 3,
	"curr_hp": 3,
	"luk": 0.5,
	"def": 1,
	"str": 1,
	"exp": 0
}

@export var SPEED: int = 800
@export var BULLET_SPEED: int = 200
@export var FIRE_RATE: float = 0.5
@onready var nav_agent: NavigationAgent2D = $Navigation/Path
var enemy_char: CharacterBody2D
var target_node: CharacterBody2D

func follow_path(delta):
	if !nav_agent.is_navigation_finished():
		var axis = to_local(nav_agent.get_next_path_position()).normalized()
		nav_agent.set_velocity(axis * SPEED * delta)

func _ready():
	$AnimatedSprite2D.play("idle")
	nav_agent.path_desired_distance = 4
	nav_agent.target_desired_distance = 4

func _physics_process(delta):
	follow_path(delta)

func _on_enemy_detector_body_entered(body):
	enemy_char = body
	$Navigation/Timer.start()

func _on_enemy_detector_body_exited(body):
	enemy_char = null
	$Navigation/Timer.stop()

func _on_navigation_path_velocity_computed(safe_velocity):
	velocity = safe_velocity
	move_and_slide()

func _on_navigation_re_calc_timer_timeout():
	SPEED = 900
	var direction_to_player = enemy_char.get_global_position() - get_global_position()
	var flee_position = get_global_position() - (direction_to_player.normalized() * 50)
	nav_agent.target_position = flee_position