extends CharacterBody2D

var CHAR_DETAIL = {
	"enemy_name": "slime",
	"atk_speed": 0.3,
	"max_hp": 20,
	"curr_hp": 20,
	"luk": 0.5,
	"def": 1,
	"str": 1,
	"exp": 0
}

@export var SPEED: int = 900
@export var type: String = ""
@export var BULLET_SPEED: int = 200
@export var FIRE_RATE: float = 0.3
@onready var nav_agent: NavigationAgent2D = $Node2D/SlimeNavigation
var player_in_area: bool = false
var enemy_shoot: bool = true
var unique_enemy: CharacterBody2D
var target_node = null
var node_list: Array

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
		"unique":
			set_to_unique()
			set_to_normal()
		_:
			set_to_normal()

func _physics_process(delta):
	if type == "unique" and unique_enemy != null:
		$BulletArea.look_at(unique_enemy.get_global_position())
	if !Autoload.prevent_attack:
		follow_path(delta)

func _on_re_calc_timer_timeout():
	if target_node and !Autoload.prevent_attack:
			nav_agent.target_position = target_node.global_position

func follow_path(delta):
	if player_in_area and !CombatDetail.is_attacking:
		$BulletArea.look_at(Autoload.player.get_global_position())
	if !nav_agent.is_navigation_finished() and !CombatDetail.is_attacking and !Autoload.prevent_attack:
		var axis = to_local(nav_agent.get_next_path_position()).normalized()
		nav_agent.set_velocity(axis * SPEED * delta)

func make_enemy_avoid_player():
	if !Autoload.prevent_attack:
		var direction_to_player = target_node.get_global_position() - get_global_position()
		var flee_position = get_global_position() - (direction_to_player.normalized() * 50)
		nav_agent.target_position = flee_position

func _on_player_detector_body_entered(body):
	if !Autoload.prevent_attack and body.is_in_group("player") and !CombatDetail.is_attacking and !player_in_area and type != "unique":
		visible = true
		target_node = body
		player_in_area = true
		$BulletTimer.wait_time = FIRE_RATE
		$BulletTimer.start()

func _on_player_detector_body_exited(body):
	if !Autoload.prevent_attack:
		player_in_area = false
		target_node = null
	
func _on_slime_navigation_velocity_computed(safe_velocity):
	velocity = safe_velocity
	move_and_slide()

func take_damage(strength):
	CHAR_DETAIL["curr_hp"] = CHAR_DETAIL["curr_hp"] - strength
	
func attacking():
	if !Autoload.prevent_attack:
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
	CHAR_DETAIL["exp"] = randi_range(20, 50)
	$PlayerDetector.set_collision_mask_value(3, false)

func set_to_normal():
	$Name.text = "Unique Slime"
	$Name.hide()
	CHAR_DETAIL["exp"] = randi_range(10, 15)
	$PlayerDetector.set_collision_mask_value(3, false)

func set_to_unique():
	$PlayerDetector.set_collision_mask_value(3, true)

func set_to_red():
	$SlimeSprite.modulate = "ff0000"
	$PlayerDetector.set_collision_mask_value(3, false)
	
func enemy_spawn_bullet():
	var bullet = load("res://scene/other/weapon/enemy_bullet/slime_bullet.tscn").instantiate()
	bullet.position = $BulletArea/BulletPoint.get_global_position()
	bullet.rotation_degrees = $BulletArea.rotation_degrees
	bullet.apply_impulse(Vector2(BULLET_SPEED, 0).rotated($BulletArea.rotation), Vector2())
	Autoload.world.add_child(bullet)

func _on_bullet_timer_timeout():
	if !Autoload.prevent_attack:
		if enemy_shoot:
			enemy_spawn_bullet()
		enemy_shoot = !enemy_shoot
		if player_in_area:
			$BulletTimer.start()
		else:
			$BulletTimer.stop()
