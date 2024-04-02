extends RigidBody2D
var DESTINATION: Vector2 = Vector2(0,0)

func _physics_process(delta):
	gravity_scale = 0

func _on_bullet_detector_body_entered(body):
	queue_free()
