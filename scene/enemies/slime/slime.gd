extends CharacterBody2D

var CHAR_DETAIL = {
	"enemy_name": "slime",
	"atk_speed": 0.3,
	"max_hp": 3,
	"curr_hp": 3,
	"luk": 0.5,
	"def": 1,
	"str": 1,
	"exp": 0
}

var SPEED = 900
var type: String = ""
var BULLET_SPEED = 200
var FIRE_RATE = 0.5
@onready var nav_agent: NavigationAgent2D = $Node2D/SlimeNavigation
var player_in_area: bool = false
var enemy_shoot: bool = true

var target_node = null

signal change_attack

func _ready():
	nav_agent.path_desired_distance = 4
	nav_agent.target_desired_distance = 4
	match type:
		"bos":
			set_to_boss()
		"red":
			set_to_red()
			set_to_normal()
		_:
			set_to_normal()

func _physics_process(delta):
	if player_in_area and !CombatDetail.is_attacking:
		$BulletArea.look_at(Autoload.player.get_global_position())

	if nav_agent.is_navigation_finished() or CombatDetail.is_attacking:
		return
	var axis = to_local(nav_agent.get_next_path_position()).normalized()
	nav_agent.set_velocity(axis * SPEED * delta)
#
func _on_re_calc_timer_timeout():
	if target_node: 
		nav_agent.target_position = target_node.global_position

func _on_player_detector_body_entered(body):
	if body.is_in_group("player") and !CombatDetail.is_attacking and !player_in_area:
		visible = true
		target_node = body
		player_in_area = true
		$BulletTimer.wait_time = FIRE_RATE
		$BulletTimer.start()

func _on_player_detector_body_exited(body):
	player_in_area = false
	
func _on_slime_navigation_velocity_computed(safe_velocity):
	velocity = safe_velocity
	move_and_slide()

func take_damage(strength):
	CHAR_DETAIL["curr_hp"] = CHAR_DETAIL["curr_hp"] - strength
	
func attacking():
	change_attack.emit()

func set_to_boss():
	$Name.text = "Slime Boss"
	$Name.show()
	$SlimeSprite.scale = Vector2(3.0, 3.0)
	$SlimeCollision.scale = Vector2(3.0, 3.0)
	$SlimeSprite.modulate = "00ff00"
	$PlayerDetector/CollisionShape2D.disabled = true
	CHAR_DETAIL["max_hp"] = CHAR_DETAIL["max_hp"] * 3
	CHAR_DETAIL["curr_hp"] = CHAR_DETAIL["max_hp"]
	CHAR_DETAIL["str"] = CHAR_DETAIL["str"] * 3
	CHAR_DETAIL["exp"] = randi_range(3000, 5000)

func set_to_normal():
	$Name.hide()
	CHAR_DETAIL["exp"] = randi_range(700, 1500)

func set_to_red():
	$SlimeSprite.modulate = "ff0000"
	
func enemy_spawn_bullet():
	var bullet = load("res://scene/other/weapon/enemy_bullet/slime_bullet.tscn").instantiate()
	bullet.position = $BulletArea/BulletPoint.get_global_position()
	bullet.rotation_degrees = $BulletArea.rotation_degrees
	bullet.apply_impulse(Vector2(BULLET_SPEED, 0).rotated($BulletArea.rotation), Vector2())	
	Autoload.world.add_child(bullet)

func fire(delta):
	print(player_in_area)

func _on_bullet_timer_timeout():
	if enemy_shoot:
		enemy_spawn_bullet()
	enemy_shoot = !enemy_shoot
	Autoload.player.CHAR_DETAIL["curr_hp"] -= 1
	if player_in_area:
		$BulletTimer.start()
	else:
		$BulletTimer.stop()