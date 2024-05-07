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

@export var SPEED: int = 900
@export var BULLET_SPEED: int = 200
@export var FIRE_RATE: float = 0.2
@onready var nav_agent: NavigationAgent2D = $Navigation/PathNavigation
var target_node: CharacterBody2D
var target_in_area: bool = true
var shoot_target: bool = false

func follow_path(delta):
	if target_node:
		$BulletArea.look_at(target_node.get_global_position())
	if !nav_agent.is_navigation_finished() and !Autoload.prevent_attack:
		var axis = to_local(nav_agent.get_next_path_position()).normalized()
		nav_agent.set_velocity(axis * SPEED * delta)

func _ready():
	$AnimatedSprite2D.play("idle")
	nav_agent.path_desired_distance = 4
	nav_agent.target_desired_distance = 4

func _physics_process(delta):
	if !Autoload.prevent_attack:
		follow_path(delta)

func _on_enemy_detector_body_entered(body):
	if body.is_in_group("player") and !Autoload.prevent_attack:
		target_in_area = true
		target_node = body
		$Navigation/TimerNavigation.start()
		$BulletArea/BulletTimer.wait_time = FIRE_RATE
		$BulletArea/BulletTimer.start()

func _on_enemy_detector_body_exited(body):
	if !Autoload.prevent_attack:
		target_node = null
		$Navigation/TimerNavigation.stop()
		target_in_area = false

func _on_re_calc_navigation_timeout():
	if target_node and !Autoload.prevent_attack:
		# SPEED = 400
		var direction_to_player = target_node.get_global_position() - get_global_position()
		var flee_position = get_global_position() - (direction_to_player.normalized() * 50)
		nav_agent.target_position = flee_position

func _on_path_navigation_velocity_computed(safe_velocity):
	if !Autoload.prevent_attack:
		if target_in_area:
			velocity = safe_velocity
		else:
			velocity = Vector2.ZERO
		move_and_slide()

func enemy_spawn_bullet():
	var bullet = load("res://scene/other/weapon/enemy_bullet/slime_bullet.tscn").instantiate()
	bullet.position = $BulletArea/BulletPoint.get_global_position()
	bullet.rotation_degrees = $BulletArea.rotation_degrees
	bullet.apply_impulse(Vector2(BULLET_SPEED, 0).rotated($BulletArea.rotation), Vector2())
	Autoload.world.add_child(bullet)

func _on_bullet_timer_timeout():
	if !Autoload.prevent_attack:
		if shoot_target:
			enemy_spawn_bullet()
		if target_in_area:
			$BulletArea/BulletTimer.start()
			shoot_target = !shoot_target
		else:
			$BulletArea/BulletTimer.stop()