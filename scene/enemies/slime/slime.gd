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

@export var SPEED = 900
@onready var nav_agent: NavigationAgent2D = $Node2D/SlimeNavigation
@export var type: String = ""

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
		visible = true
		target_node = body
	
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
	
